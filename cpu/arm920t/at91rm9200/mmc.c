/*
 * (C) Copyright 2003
 * Kyle Harris, Nexus Technologies, Inc. kharris@nexus-tech.net
 *
 * (C) Copyright 2005
 * Doerte Waldoestl, Ident Technologies GmbH waldoestl@identtechnologies.de
 * Changed to support AT91RM92000 MMC Interface for reads
 *
 * See file CREDITS for list of people who contributed to this
 * project.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of
 * the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
 * MA 02111-1307 USA
 */

#include <config.h>
#include <common.h>
#include <mmc.h>
#include <asm/errno.h>
#include <part.h>

#ifdef CONFIG_MMC

/* Prevents double occurence of all functions in lib_AT91RM9200.h*/
/* functions are not inlined, thats why c-file is included and not h-file */  

#include "mci_device.c" 

extern int fat_register_device(block_dev_desc_t *dev_desc, int part_no);
/* Local variables */
static block_dev_desc_t mmc_dev;
										
block_dev_desc_t * mmc_get_dev(int dev)
{
	return ((block_dev_desc_t *)&mmc_dev);
}

#define AT91C_MCI_TIMEOUT			1000000   /* For AT91F_MCIDeviceWaitReady */
#define FALSE						-1
#define TRUE						1

/* External Functions  in mci_device.c*/
extern void AT91F_ASM_MCI_Handler(void);
extern void AT91F_MCI_Device_Handler(AT91PS_MciDevice,unsigned int);

extern AT91S_MCIDeviceStatus 	AT91F_MCI_SDCard_Init (AT91PS_MciDevice);
extern AT91S_MCIDeviceStatus	AT91F_MCI_MMC_Init(AT91PS_MciDevice);
extern AT91S_MCIDeviceStatus 	AT91F_MCI_SetBlocklength(AT91PS_MciDevice,unsigned int);
extern AT91S_MCIDeviceStatus 	AT91F_MCI_MMC_SelectCard(AT91PS_MciDevice,unsigned int);
extern AT91S_MCIDeviceStatus 	AT91F_MCI_ReadBlock(AT91PS_MciDevice,int,unsigned int *,int);
extern AT91S_MCIDeviceStatus 	AT91F_MCI_WriteBlock(AT91PS_MciDevice,int,unsigned int *,int);

/* Local Functions */
void AT91F_MCIDeviceWaitReady	(unsigned int timeout);
void AT91F_MCI_CorrectByteOrder(uchar *pBuffer, int len);

//* Global Variables
AT91S_MciDeviceFeatures			MCI_Device_Features;
AT91S_MciDeviceDesc				MCI_Device_Desc;
AT91S_MciDevice					MCI_Device;
//Targetbuffer for DMA transfers
static uchar					mmc_buf[CFG_MMC_BLOCKSIZE];

static int at91sdcard_init(void);
static ulong mmc_bread(int dev_num, ulong blknr, ulong blkcnt, ulong *dst);

int
/****************************************************/
mmc_block_read(uchar *dst, ulong src, ulong len)
/****************************************************/
{
	
	AT91S_MCIDeviceStatus status;
	if (len > CFG_MMC_BLOCKSIZE) {
		printf ("mmc_block_read: Error len (%x) > Blocksize \n",len);
		return -1;
	}
	
	status = AT91F_MCI_ReadBlock(&MCI_Device, src, mmc_buf,len);
	if (status != AT91C_READ_OK) {
		printf ("mmc_block_read: Error read %d to dst\n", status);
		return -1;
	}
	//* Wait end of Read
	AT91F_MCIDeviceWaitReady(AT91C_MCI_TIMEOUT);

	if (dst != mmc_buf) {
		memcpy(dst,mmc_buf,len);
	}
	
	AT91F_MCI_CorrectByteOrder(dst,len);
	
	return 0;
}

int
/****************************************************/
mmc_read(ulong src, uchar *dst, int size)
/****************************************************/
{
	ulong end, part_start, part_end, part_len, aligned_start, aligned_end;
	ulong mmc_block_size, mmc_block_address;

	if (size == 0) {
		return 0;
	}

	if (!MCI_Device.pMCI_DeviceFeatures->Max_Read_DataBlock_Length) {
		printf("Please initial the MMC first\n");
		return -1;
	}

	mmc_block_size = CFG_MMC_BLOCKSIZE;
	mmc_block_address = ~(mmc_block_size - 1);

	src -= CFG_MMC_BASE;
	end = src + size;
	part_start = ~mmc_block_address & src;
	part_end = ~mmc_block_address & end;
	aligned_start = mmc_block_address & src;
	aligned_end = mmc_block_address & end;

	/* all block aligned accesses */
	debug("src %lx dst %lx end %lx pstart %lx pend %lx astart %lx aend %lx\n",
	src, (ulong)dst, end, part_start, part_end, aligned_start, aligned_end);
	if (part_start) {
		part_len = mmc_block_size - part_start;
		debug("ps src %lx dst %lx end %lx pstart %lx pend %lx astart %lx aend %lx\n",
		src, (ulong)dst, end, part_start, part_end, aligned_start, aligned_end);
		if ((mmc_block_read(mmc_buf, aligned_start, mmc_block_size)) < 0) {
			return -1;
		}
		memcpy(dst, mmc_buf+part_start, part_len);
		dst += part_len;
		src += part_len;
	}
	debug("src %lx dst %lx end %lx pstart %lx pend %lx astart %lx aend %lx\n",
	src, (ulong)dst, end, part_start, part_end, aligned_start, aligned_end);
	for (; src < aligned_end; src += mmc_block_size, dst += mmc_block_size) {
		debug("al src %lx dst %lx end %lx pstart %lx pend %lx astart %lx aend %lx\n",
		src, (ulong)dst, end, part_start, part_end, aligned_start, aligned_end);
		if ((mmc_block_read((uchar *)(dst), src, mmc_block_size)) < 0) {
			return -1;
		}
	}
	debug("src %lx dst %lx end %lx pstart %lx pend %lx astart %lx aend %lx\n",
	src, (ulong)dst, end, part_start, part_end, aligned_start, aligned_end);
	if (part_end && src < end) {
		debug("pe src %lx dst %lx end %lx pstart %lx pend %lx astart %lx aend %lx\n",
		src, (ulong)dst, end, part_start, part_end, aligned_start, aligned_end);
		if ((mmc_block_read(mmc_buf, aligned_end, mmc_block_size)) < 0) {
			return -1;
		}
		memcpy(dst, mmc_buf, part_end);
	}
	return 0;
}
/****************************************************/
int mmc_init(int verbose)
/****************************************************/
{
	at91sdcard_init();
	printf ("Card found with %u MB size\r\n",MCI_Device.pMCI_DeviceFeatures[0].Memory_Capacity>>20);
	/* fill in device description */
	mmc_dev.if_type = IF_TYPE_MMC;
	mmc_dev.part_type = PART_TYPE_DOS;
	mmc_dev.dev = 0;
	mmc_dev.lun = 0;
	mmc_dev.type = 0;
	mmc_dev.blksz = MCI_Device.pMCI_DeviceFeatures[0].Max_Read_DataBlock_Length;
	mmc_dev.lba = MCI_Device.pMCI_DeviceFeatures[0].Memory_Capacity >> 9;
	sprintf(mmc_dev.vendor,"Man %02x%02x%02x Snr %02x%02x%02x", 0, 0,0,0,0,0);
	sprintf(mmc_dev.product,"%s","unknown");
	sprintf(mmc_dev.revision,"%x %x",0, 0);
	mmc_dev.removable = 0;
	mmc_dev.block_read = mmc_bread;

	fat_register_device(&mmc_dev,1);
	return 0;
}

/****************************************************/
int mmc_write(uchar *src, ulong dst, int size)
/****************************************************/
{
	return 0;
}

/****************************************************/
/* This function is used to correct ATMEL errata: big endian read/write on MCI*/
inline void doswap(unsigned char *x, unsigned char *y)
{
   /* Exchanging values with xor
	* Here's some weird code I ran across once. 
	* It uses xor to exchange two values (x and y). 
	* Never use it; ;-) this is just a curiosity from the museum of bizarre code.
	*/
		/**x = *x ^ *y;
		*y = *x ^ *y;
		*x = *x ^ *y;*/
	unsigned char t=*y;
	*y=*x;
	*x=t;
}
void AT91F_MCI_CorrectByteOrder(uchar *pBuffer, int len)
{
	unsigned char *pEnd = pBuffer + len;
	unsigned char *p;

	for(p=pBuffer;p<pEnd;p+=4) {
		doswap(p+0,p+3);
		doswap(p+1,p+2);
	}
}
ulong
/****************************************************/
mmc_bread(int dev_num, ulong blknr, ulong blkcnt, ulong *dst)
/****************************************************/
{
	int mmc_block_size = CFG_MMC_BLOCKSIZE;
	ulong src = blknr * mmc_block_size + CFG_MMC_BASE;

	mmc_read(src, (uchar *)dst, blkcnt*mmc_block_size);
	return blkcnt;
}


int mmc_ident(block_dev_desc_t *dev)
{
	return 0;
}

int mmc2info(ulong addr)
{
	
	ulong capacity = MCI_Device.pMCI_DeviceFeatures[0].Memory_Capacity;
	long laddr;

	laddr = addr - (long)AT91C_BASE_MCI;
	if (laddr < 0) {
		printf (" addr lower than AT91C_BASE_MCI\n");
		return 0;
	}
	if (laddr > capacity) {
		printf (" addr higher than AT91C_BASE_MCI + capacity\n");
		return 0;
	}
	printf ("Ok\n");
	return 1;
	
}

//*----------------------------------------------------------------------------
//* \fn    AT91F_MCIDeviceWaitReady
//* \brief Wait for MCI Device ready
//*----------------------------------------------------------------------------
void AT91F_MCIDeviceWaitReady(unsigned int timeout)
{
	volatile int status;
	
	do
	{
		status = AT91C_BASE_MCI->MCI_SR;
		timeout--;
	}
	while( !(status & AT91C_MCI_NOTBUSY)  && (timeout>0) );	
}

//*----------------------------------------------------------------------------
//* \fn    AT91F_CfgDevice
//* \brief This function is used to initialise MMC or SDCard Features
//*----------------------------------------------------------------------------
void AT91F_CfgDevice(void)
{
	// Init Device Structure

	MCI_Device_Features.Relative_Card_Address 		= 0;
	MCI_Device_Features.Card_Inserted 				= AT91C_CARD_REMOVED;
	MCI_Device_Features.Max_Read_DataBlock_Length	= 0;
	MCI_Device_Features.Max_Write_DataBlock_Length 	= 0;
	MCI_Device_Features.Read_Partial 				= 0;
	MCI_Device_Features.Write_Partial 				= 0;
	MCI_Device_Features.Erase_Block_Enable 			= 0;
	MCI_Device_Features.Sector_Size 				= 0;
	MCI_Device_Features.Memory_Capacity 			= 0;
	
	MCI_Device_Desc.state							= AT91C_MCI_IDLE;
	MCI_Device_Desc.SDCard_bus_width				= AT91C_MCI_SCDBUS;
	
	// Init AT91S_DataFlash Global Structure, by default AT45DB choosen !!!
	MCI_Device.pMCI_DeviceDesc 		= &MCI_Device_Desc;
	MCI_Device.pMCI_DeviceFeatures 	= &MCI_Device_Features;

}

//*----------------------------------------------------------------------------
//* \fn    AT91F_Test_SDCard
//* \brief Configure MCI for SDCard and complete SDCard init, then jump to Test Functions
//*----------------------------------------------------------------------------
int AT91F_Test_SDCard(void)
{
	/*
	 * For SDCard Init
	 */

	AT91F_MCI_Configure(AT91C_BASE_MCI, 
			AT91C_MCI_DTOR_1MEGA_CYCLES, 
			AT91C_MCI_MR_PDCMODE	/* 15MHz for MCK = 60MHz (CLKDIV = 1)*/, 
			AT91C_MCI_SDCARD_4BITS_SLOTA);
	
	if(AT91F_MCI_SDCard_Init(&MCI_Device) != AT91C_INIT_OK)
		return FALSE;
	return(TRUE);
}

//*----------------------------------------------------------------------------
//* \fn    AT91F_MCI_Handler
//* \brief MCI Handler
//*----------------------------------------------------------------------------
void AT91F_MCI_Handler(void)
{
	int status;
	status = ( AT91C_BASE_MCI->MCI_SR & AT91C_BASE_MCI->MCI_IMR );
	AT91F_MCI_Device_Handler(&MCI_Device,status);
}


//*----------------------------------------------------------------------------
//* \fn    at91sdcard_init
//* \brief at91sdcard_init function
//*----------------------------------------------------------------------------
static int at91sdcard_init(void)
{
	// Set up PIO SDC_TYPE to switch on MMC/SDCard and not DataFlash Card
	AT91F_PIO_CfgOutput(AT91C_BASE_PIOB,AT91C_PIO_PB7);
	AT91F_PIO_SetOutput(AT91C_BASE_PIOB,AT91C_PIO_PB7);
	
	// Init MCI for MMC and SDCard interface
	AT91F_MCI_CfgPIO();	
	AT91F_MCI_CfgPMC();
	AT91F_PDC_Open(AT91C_BASE_PDC_MCI);

	// Disable all the interrupts
	AT91C_BASE_MCI->MCI_IDR = 0xFFFFFFFF;

	// Init MCI Device Structures
	AT91F_CfgDevice();
	
	// Configure MCI interrupt 
	AT91F_AIC_ConfigureIt(AT91C_BASE_AIC,
						 AT91C_ID_MCI,
						 AT91C_AIC_PRIOR_HIGHEST,
						 AT91C_AIC_SRCTYPE_INT_LEVEL_SENSITIVE,
						 AT91F_MCI_Handler);

	// Enable MCI interrupt
	AT91F_AIC_EnableIt(AT91C_BASE_AIC,AT91C_ID_MCI);


	if(AT91F_Test_SDCard() == TRUE)
		printf("\n\rTests MCI SDCard Successful !!!\n\r");
	else
		printf("\n\rTests MCI SDCard Failed !!!\n\r");
}
			
#endif


