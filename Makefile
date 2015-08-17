

aev_config: unconfig
	@$(MKCONFIG) -a aev ppc mpc5xxx tqm5200

BC3450_config:	unconfig
	@$(MKCONFIG) -a BC3450 ppc mpc5xxx bc3450

cpci5200_config:  unconfig
	@$(MKCONFIG) -a cpci5200  ppc mpc5xxx cpci5200 esd

hmi1001_config:         unconfig
	@$(MKCONFIG) hmi1001 ppc mpc5xxx hmi1001

Lite5200_config				\
Lite5200_LOWBOOT_config			\
Lite5200_LOWBOOT08_config		\
icecube_5200_config			\
icecube_5200_LOWBOOT_config		\
icecube_5200_LOWBOOT08_config		\
icecube_5200_DDR_config 		\
icecube_5200_DDR_LOWBOOT_config 	\
icecube_5200_DDR_LOWBOOT08_config	\
icecube_5100_config:			unconfig
	@mkdir -p $(obj)include
	@mkdir -p $(obj)board/icecube
	@ >$(obj)include/config.h
	@[ -z "$(findstring LOWBOOT_,$@)" ] || \
		{ if [ "$(findstring DDR,$@)" ] ; \
			then echo "TEXT_BASE = 0xFF800000" >$(obj)board/icecube/config.tmp ; \
			else echo "TEXT_BASE = 0xFF000000" >$(obj)board/icecube/config.tmp ; \
		  fi ; \
		  echo "... with LOWBOOT configuration" ; \
		}
	@[ -z "$(findstring LOWBOOT08,$@)" ] || \
		{ echo "TEXT_BASE = 0xFF800000" >$(obj)board/icecube/config.tmp ; \
		  echo "... with 8 MB flash only" ; \
		  echo "... with LOWBOOT configuration" ; \
		}
	@[ -z "$(findstring DDR,$@)" ] || \
		{ echo "#define CONFIG_MPC5200_DDR"	>>$(obj)include/config.h ; \
		  echo "... DDR memory revision" ; \
		}
	@[ -z "$(findstring 5200,$@)" ] || \
		{ echo "#define CONFIG_MPC5200"		>>$(obj)include/config.h ; \
		  echo "... with MPC5200 processor" ; \
		}
	@[ -z "$(findstring 5100,$@)" ] || \
		{ echo "#define CONFIG_MGT5100"		>>$(obj)include/config.h ; \
		  echo "... with MGT5100 processor" ; \
		}
	@$(MKCONFIG) -a IceCube ppc mpc5xxx icecube

v38b_config: unconfig
	@./mkconfig -a V38B ppc mpc5xxx v38b

inka4x0_config:	unconfig
	@$(MKCONFIG) inka4x0 ppc mpc5xxx inka4x0

lite5200b_config	\
lite5200b_LOWBOOT_config:	unconfig
	@mkdir -p $(obj)include
	@mkdir -p $(obj)board/icecube
	@ >$(obj)include/config.h
	@ echo "#define CONFIG_MPC5200_DDR"	>>$(obj)include/config.h
	@ echo "... DDR memory revision"
	@ echo "#define CONFIG_MPC5200"		>>$(obj)include/config.h
	@ echo "#define CONFIG_LITE5200B"	>>$(obj)include/config.h
	@[ -z "$(findstring LOWBOOT_,$@)" ] || \
		{ echo "TEXT_BASE = 0xFF000000" >$(obj)board/icecube/config.tmp ; \
		  echo "... with LOWBOOT configuration" ; \
		}
	@ echo "... with MPC5200B processor"
	@$(MKCONFIG) -a IceCube  ppc mpc5xxx icecube

mcc200_config	\
mcc200_SDRAM_config	\
mcc200_highboot_config	\
mcc200_COM12_config	\
mcc200_COM12_SDRAM_config	\
mcc200_COM12_highboot_config	\
mcc200_COM12_highboot_SDRAM_config	\
mcc200_highboot_SDRAM_config	\
prs200_config	\
prs200_DDR_config	\
prs200_highboot_config	\
prs200_highboot_DDR_config:	unconfig
	@mkdir -p $(obj)include
	@mkdir -p $(obj)board/mcc200
	@ >$(obj)include/config.h
	@[ -n "$(findstring highboot,$@)" ] || \
		{ echo "... with lowboot configuration" ; \
		}
	@[ -z "$(findstring highboot,$@)" ] || \
		{ echo "TEXT_BASE = 0xFFF00000" >$(obj)board/mcc200/config.tmp ; \
		  echo "... with highboot configuration" ; \
		}
	@[ -n "$(findstring _SDRAM,$@)" ] || \
		{ if [ -n "$(findstring mcc200,$@)" ]; \
		  then \
		  	echo "... with DDR" ; \
		  else \
			if [ -n "$(findstring _DDR,$@)" ];\
			then \
				echo "... with DDR" ; \
			else \
				echo "#define CONFIG_MCC200_SDRAM" >>$(obj)include/config.h ;\
				echo "... with SDRAM" ; \
			fi; \
		  fi; \
		}
	@[ -z "$(findstring _SDRAM,$@)" ] || \
		{ echo "#define CONFIG_MCC200_SDRAM"	>>$(obj)include/config.h ; \
		  echo "... with SDRAM" ; \
		}
	@[ -z "$(findstring COM12,$@)" ] || \
		{ echo "#define CONFIG_CONSOLE_COM12"	>>$(obj)include/config.h ; \
		  echo "... with console on COM12" ; \
		}
	@[ -z "$(findstring prs200,$@)" ] || \
		{ echo "#define CONFIG_PRS200"  >>$(obj)include/config.h ;\
		}
	@$(MKCONFIG) -n $@ -a mcc200 ppc mpc5xxx mcc200

o2dnt_config:
	@$(MKCONFIG) o2dnt ppc mpc5xxx o2dnt

pf5200_config:  unconfig
	@$(MKCONFIG) pf5200  ppc mpc5xxx pf5200 esd

PM520_config \
PM520_DDR_config \
PM520_ROMBOOT_config \
PM520_ROMBOOT_DDR_config:	unconfig
	@mkdir -p $(obj)include
	@ >$(obj)include/config.h
	@[ -z "$(findstring DDR,$@)" ] || \
		{ echo "#define CONFIG_MPC5200_DDR"	>>$(obj)include/config.h ; \
		  echo "... DDR memory revision" ; \
		}
	@[ -z "$(findstring ROMBOOT,$@)" ] || \
		{ echo "#define CONFIG_BOOT_ROM" >>$(obj)include/config.h ; \
		  echo "... booting from 8-bit flash" ; \
		}
	@$(MKCONFIG) -a PM520 ppc mpc5xxx pm520

smmaco4_config: unconfig
	@$(MKCONFIG) -a smmaco4 ppc mpc5xxx tqm5200

spieval_config:	unconfig
	@$(MKCONFIG) -a spieval ppc mpc5xxx tqm5200

TB5200_B_config \
TB5200_config:	unconfig
	@mkdir -p $(obj)include
	@[ -z "$(findstring _B,$@)" ] || \
		{ echo "#define CONFIG_TQM5200_B"	>>$(obj)include/config.h ; \
		  echo "... with MPC5200B processor" ; \
		}
	@$(MKCONFIG) -n $@ -a TB5200 ppc mpc5xxx tqm5200

MINI5200_config	\
EVAL5200_config	\
TOP5200_config:	unconfig
	@mkdir -p $(obj)include
	@ echo "#define CONFIG_$(@:_config=) 1"	>$(obj)include/config.h
	@$(MKCONFIG) -n $@ -a TOP5200 ppc mpc5xxx top5200 emk

Total5100_config		\
Total5200_config		\
Total5200_lowboot_config	\
Total5200_Rev2_config		\
Total5200_Rev2_lowboot_config:	unconfig
	@mkdir -p $(obj)include
	@mkdir -p $(obj)board/total5200
	@ >$(obj)include/config.h
	@[ -z "$(findstring 5100,$@)" ] || \
		{ echo "#define CONFIG_MGT5100"		>>$(obj)include/config.h ; \
		  echo "... with MGT5100 processor" ; \
		}
	@[ -z "$(findstring 5200,$@)" ] || \
		{ echo "#define CONFIG_MPC5200"		>>$(obj)include/config.h ; \
		  echo "... with MPC5200 processor" ; \
		}
	@[ -n "$(findstring Rev,$@)" ] || \
		{ echo "#define CONFIG_TOTAL5200_REV 1"	>>$(obj)include/config.h ; \
		  echo "... revision 1 board" ; \
		}
	@[ -z "$(findstring Rev2_,$@)" ] || \
		{ echo "#define CONFIG_TOTAL5200_REV 2"	>>$(obj)include/config.h ; \
		  echo "... revision 2 board" ; \
		}
	@[ -z "$(findstring lowboot_,$@)" ] || \
		{ echo "TEXT_BASE = 0xFE000000" >$(obj)board/total5200/config.tmp ; \
		  echo "... with lowboot configuration" ; \
		}
	@$(MKCONFIG) -a Total5200 ppc mpc5xxx total5200

cam5200_config \
fo300_config \
MiniFAP_config \
TQM5200S_config \
TQM5200S_HIGHBOOT_config \
TQM5200_B_config \
TQM5200_B_HIGHBOOT_config \
TQM5200_config	\
TQM5200_STK100_config:	unconfig
	@mkdir -p $(obj)include
	@mkdir -p $(obj)board/tqm5200
	@ >$(obj)include/config.h
	@[ -z "$(findstring cam5200,$@)" ] || \
		{ echo "#define CONFIG_CAM5200"	>>$(obj)include/config.h ; \
		  echo "#define CONFIG_TQM5200S"	>>$(obj)include/config.h ; \
		  echo "#define CONFIG_TQM5200_B"	>>$(obj)include/config.h ; \
		  echo "... TQM5200S on Cam5200" ; \
		}
	@[ -z "$(findstring fo300,$@)" ] || \
		{ echo "#define CONFIG_FO300"	>>$(obj)include/config.h ; \
		  echo "... TQM5200 on FO300" ; \
		}
	@[ -z "$(findstring MiniFAP,$@)" ] || \
		{ echo "#define CONFIG_MINIFAP"	>>$(obj)include/config.h ; \
		  echo "... TQM5200_AC on MiniFAP" ; \
		}
	@[ -z "$(findstring STK100,$@)" ] || \
		{ echo "#define CONFIG_STK52XX_REV100"	>>$(obj)include/config.h ; \
		  echo "... on a STK52XX.100 base board" ; \
		}
	@[ -z "$(findstring TQM5200_B,$@)" ] || \
		{ echo "#define CONFIG_TQM5200_B"	>>$(obj)include/config.h ; \
		}
	@[ -z "$(findstring TQM5200S,$@)" ] || \
		{ echo "#define CONFIG_TQM5200S"	>>$(obj)include/config.h ; \
		  echo "#define CONFIG_TQM5200_B"	>>$(obj)include/config.h ; \
		}
	@[ -z "$(findstring HIGHBOOT,$@)" ] || \
		{ echo "TEXT_BASE = 0xFFF00000" >$(obj)board/tqm5200/config.tmp ; \
		}
	@$(MKCONFIG) -n $@ -a TQM5200 ppc mpc5xxx tqm5200

#########################################################################
## MPC8xx Systems
#########################################################################

Adder_config    \
Adder87x_config \
AdderII_config  \
	:		unconfig
	@mkdir -p $(obj)include
	$(if $(findstring AdderII,$@), \
	@echo "#define CONFIG_MPC852T" > $(obj)include/config.h)
	@$(MKCONFIG) -a Adder ppc mpc8xx adder

ADS860_config     \
FADS823_config    \
FADS850SAR_config \
MPC86xADS_config  \
MPC885ADS_config  \
FADS860T_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc8xx fads

AMX860_config	:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc8xx amx860 westel

c2mon_config:		unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc8xx c2mon

CCM_config:		unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc8xx CCM siemens

cogent_mpc8xx_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc8xx cogent

ELPT860_config:		unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc8xx elpt860 LEOX

EP88x_config:		unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc8xx ep88x

ESTEEM192E_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc8xx esteem192e

ETX094_config	:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc8xx etx094

FLAGADM_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc8xx flagadm

xtract_GEN860T = $(subst _SC,,$(subst _config,,$1))

GEN860T_SC_config	\
GEN860T_config: unconfig
	@mkdir -p $(obj)include
	@ >$(obj)include/config.h
	@[ -z "$(findstring _SC,$@)" ] || \
		{ echo "#define CONFIG_SC" >>$(obj)include/config.h ; \
		  echo "With reduced H/W feature set (SC)..." ; \
		}
	@$(MKCONFIG) -a $(call xtract_GEN860T,$@) ppc mpc8xx gen860t

GENIETV_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc8xx genietv

GTH_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc8xx gth

hermes_config	:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc8xx hermes

HMI10_config	:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc8xx tqm8xx

IAD210_config: unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc8xx IAD210 siemens

xtract_ICU862 = $(subst _100MHz,,$(subst _config,,$1))

ICU862_100MHz_config	\
ICU862_config: unconfig
	@mkdir -p $(obj)include
	@ >$(obj)include/config.h
	@[ -z "$(findstring _100MHz,$@)" ] || \
		{ echo "#define CONFIG_100MHz"	>>$(obj)include/config.h ; \
		  echo "... with 100MHz system clock" ; \
		}
	@$(MKCONFIG) -a $(call xtract_ICU862,$@) ppc mpc8xx icu862

IP860_config	:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc8xx ip860

IVML24_256_config \
IVML24_128_config \
IVML24_config:	unconfig
	@mkdir -p $(obj)include
	@ >$(obj)include/config.h
	@[ -z "$(findstring IVML24_config,$@)" ] || \
		 { echo "#define CONFIG_IVML24_16M"	>>$(obj)include/config.h ; \
		 }
	@[ -z "$(findstring IVML24_128_config,$@)" ] || \
		 { echo "#define CONFIG_IVML24_32M"	>>$(obj)include/config.h ; \
		 }
	@[ -z "$(findstring IVML24_256_config,$@)" ] || \
		 { echo "#define CONFIG_IVML24_64M"	>>$(obj)include/config.h ; \
		 }
	@$(MKCONFIG) -a IVML24 ppc mpc8xx ivm

IVMS8_256_config \
IVMS8_128_config \
IVMS8_config:	unconfig
	@mkdir -p $(obj)include
	@ >$(obj)include/config.h
	@[ -z "$(findstring IVMS8_config,$@)" ] || \
		 { echo "#define CONFIG_IVMS8_16M"	>>$(obj)include/config.h ; \
		 }
	@[ -z "$(findstring IVMS8_128_config,$@)" ] || \
		 { echo "#define CONFIG_IVMS8_32M"	>>$(obj)include/config.h ; \
		 }
	@[ -z "$(findstring IVMS8_256_config,$@)" ] || \
		 { echo "#define CONFIG_IVMS8_64M"	>>$(obj)include/config.h ; \
		 }
	@$(MKCONFIG) -a IVMS8 ppc mpc8xx ivm

KUP4K_config	:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc8xx kup4k kup

KUP4X_config    :       unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc8xx kup4x kup

LANTEC_config	:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc8xx lantec

lwmon_config:		unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc8xx lwmon

MBX_config	\
MBX860T_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc8xx mbx8xx

MHPC_config:		unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc8xx mhpc eltec

MVS1_config :		unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc8xx mvs1

xtract_NETVIA = $(subst _V2,,$(subst _config,,$1))

NETVIA_V2_config \
NETVIA_config:		unconfig
	@mkdir -p $(obj)include
	@ >$(obj)include/config.h
	@[ -z "$(findstring NETVIA_config,$@)" ] || \
		 { echo "#define CONFIG_NETVIA_VERSION 1" >>$(obj)include/config.h ; \
		  echo "... Version 1" ; \
		 }
	@[ -z "$(findstring NETVIA_V2_config,$@)" ] || \
		 { echo "#define CONFIG_NETVIA_VERSION 2" >>$(obj)include/config.h ; \
		  echo "... Version 2" ; \
		 }
	@$(MKCONFIG) -a $(call xtract_NETVIA,$@) ppc mpc8xx netvia

xtract_NETPHONE = $(subst _V2,,$(subst _config,,$1))

NETPHONE_V2_config \
NETPHONE_config:	unconfig
	@mkdir -p $(obj)include
	@ >$(obj)include/config.h
	@[ -z "$(findstring NETPHONE_config,$@)" ] || \
		 { echo "#define CONFIG_NETPHONE_VERSION 1" >>$(obj)include/config.h ; \
		 }
	@[ -z "$(findstring NETPHONE_V2_config,$@)" ] || \
		 { echo "#define CONFIG_NETPHONE_VERSION 2" >>$(obj)include/config.h ; \
		 }
	@$(MKCONFIG) -a $(call xtract_NETPHONE,$@) ppc mpc8xx netphone

xtract_NETTA = $(subst _SWAPHOOK,,$(subst _6412,,$(subst _ISDN,,$(subst _config,,$1))))

NETTA_ISDN_6412_SWAPHOOK_config \
NETTA_ISDN_SWAPHOOK_config \
NETTA_6412_SWAPHOOK_config \
NETTA_SWAPHOOK_config \
NETTA_ISDN_6412_config \
NETTA_ISDN_config \
NETTA_6412_config \
NETTA_config:		unconfig
	@mkdir -p $(obj)include
	@ >$(obj)include/config.h
	@[ -z "$(findstring ISDN_,$@)" ] || \
		 { echo "#define CONFIG_NETTA_ISDN 1" >>$(obj)include/config.h ; \
		 }
	@[ -n "$(findstring ISDN_,$@)" ] || \
		 { echo "#undef CONFIG_NETTA_ISDN" >>$(obj)include/config.h ; \
		 }
	@[ -z "$(findstring 6412_,$@)" ] || \
		 { echo "#define CONFIG_NETTA_6412 1" >>$(obj)include/config.h ; \
		 }
	@[ -n "$(findstring 6412_,$@)" ] || \
		 { echo "#undef CONFIG_NETTA_6412" >>$(obj)include/config.h ; \
		 }
	@[ -z "$(findstring SWAPHOOK_,$@)" ] || \
		 { echo "#define CONFIG_NETTA_SWAPHOOK 1" >>$(obj)include/config.h ; \
		 }
	@[ -n "$(findstring SWAPHOOK_,$@)" ] || \
		 { echo "#undef CONFIG_NETTA_SWAPHOOK" >>$(obj)include/config.h ; \
		 }
	@$(MKCONFIG) -a $(call xtract_NETTA,$@) ppc mpc8xx netta

xtract_NETTA2 = $(subst _V2,,$(subst _config,,$1))

NETTA2_V2_config \
NETTA2_config:		unconfig
	@mkdir -p $(obj)include
	@ >$(obj)include/config.h
	@[ -z "$(findstring NETTA2_config,$@)" ] || \
		 { echo "#define CONFIG_NETTA2_VERSION 1" >>$(obj)include/config.h ; \
		 }
	@[ -z "$(findstring NETTA2_V2_config,$@)" ] || \
		 { echo "#define CONFIG_NETTA2_VERSION 2" >>$(obj)include/config.h ; \
		 }
	@$(MKCONFIG) -a $(call xtract_NETTA2,$@) ppc mpc8xx netta2

NC650_Rev1_config \
NC650_Rev2_config \
CP850_config:	unconfig
	@mkdir -p $(obj)include
	@ >$(obj)include/config.h
	@[ -z "$(findstring CP850,$@)" ] || \
		 { echo "#define CONFIG_CP850 1" >>$(obj)include/config.h ; \
		   echo "#define CONFIG_IDS852_REV2 1" >>$(obj)include/config.h ; \
		 }
	@[ -z "$(findstring Rev1,$@)" ] || \
		 { echo "#define CONFIG_IDS852_REV1 1" >>$(obj)include/config.h ; \
		 }
	@[ -z "$(findstring Rev2,$@)" ] || \
		 { echo "#define CONFIG_IDS852_REV2 1" >>$(obj)include/config.h ; \
		 }
	@$(MKCONFIG) -a NC650 ppc mpc8xx nc650

NX823_config:		unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc8xx nx823

pcu_e_config:		unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc8xx pcu_e siemens

QS850_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc8xx qs850 snmc

QS823_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc8xx qs850 snmc

QS860T_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc8xx qs860t snmc

quantum_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc8xx quantum

R360MPI_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc8xx r360mpi

RBC823_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc8xx rbc823

RPXClassic_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc8xx RPXClassic

RPXlite_config:		unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc8xx RPXlite

RPXlite_DW_64_config  		\
RPXlite_DW_LCD_config 		\
RPXlite_DW_64_LCD_config 	\
RPXlite_DW_NVRAM_config		\
RPXlite_DW_NVRAM_64_config      \
RPXlite_DW_NVRAM_LCD_config	\
RPXlite_DW_NVRAM_64_LCD_config  \
RPXlite_DW_config:         unconfig
	@mkdir -p $(obj)include
	@ >$(obj)include/config.h
	@[ -z "$(findstring _64,$@)" ] || \
		{ echo "#define RPXlite_64MHz"		>>$(obj)include/config.h ; \
		  echo "... with 64MHz system clock ..."; \
		}
	@[ -z "$(findstring _LCD,$@)" ] || \
		{ echo "#define CONFIG_LCD"          	>>$(obj)include/config.h ; \
		  echo "#define CONFIG_NEC_NL6448BC20"	>>$(obj)include/config.h ; \
		  echo "... with LCD display ..."; \
		}
	@[ -z "$(findstring _NVRAM,$@)" ] || \
		{ echo "#define  CFG_ENV_IS_IN_NVRAM" 	>>$(obj)include/config.h ; \
		  echo "... with ENV in NVRAM ..."; \
		}
	@$(MKCONFIG) -a RPXlite_DW ppc mpc8xx RPXlite_dw

rmu_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc8xx rmu

RRvision_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc8xx RRvision

RRvision_LCD_config:	unconfig
	@mkdir -p $(obj)include
	@echo "#define CONFIG_LCD" >$(obj)include/config.h
	@echo "#define CONFIG_SHARP_LQ104V7DS01" >>$(obj)include/config.h
	@$(MKCONFIG) -a RRvision ppc mpc8xx RRvision

SM850_config	:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc8xx tqm8xx

spc1920_config:
	@$(MKCONFIG) $(@:_config=) ppc mpc8xx spc1920

SPD823TS_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc8xx spd8xx

stxxtc_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc8xx stxxtc

svm_sc8xx_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc8xx svm_sc8xx

SXNI855T_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc8xx sixnet

# EMK MPC8xx based modules
TOP860_config:		unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc8xx top860 emk

# Play some tricks for configuration selection
# Only 855 and 860 boards may come with FEC
# and only 823 boards may have LCD support
xtract_8xx = $(subst _LCD,,$(subst _config,,$1))

FPS850L_config		\
FPS860L_config		\
NSCU_config		\
TQM823L_config		\
TQM823L_LCD_config	\
TQM850L_config		\
TQM855L_config		\
TQM860L_config		\
TQM862L_config		\
TQM823M_config		\
TQM850M_config		\
TQM855M_config		\
TQM860M_config		\
TQM862M_config		\
TQM866M_config		\
TQM885D_config		\
virtlab2_config:	unconfig
	@mkdir -p $(obj)include
	@ >$(obj)include/config.h
	@[ -z "$(findstring _LCD,$@)" ] || \
		{ echo "#define CONFIG_LCD"		>>$(obj)include/config.h ; \
		  echo "#define CONFIG_NEC_NL6448BC20"	>>$(obj)include/config.h ; \
		  echo "... with LCD display" ; \
		}
	@$(MKCONFIG) -a $(call xtract_8xx,$@) ppc mpc8xx tqm8xx

TTTech_config:	unconfig
	@mkdir -p $(obj)include
	@echo "#define CONFIG_LCD" >$(obj)include/config.h
	@echo "#define CONFIG_SHARP_LQ104V7DS01" >>$(obj)include/config.h
	@$(MKCONFIG) -a TQM823L ppc mpc8xx tqm8xx

uc100_config	:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc8xx uc100

v37_config:	unconfig
	@mkdir -p $(obj)include
	@echo "#define CONFIG_LCD" >$(obj)include/config.h
	@echo "#define CONFIG_SHARP_LQ084V1DG21" >>$(obj)include/config.h
	@$(MKCONFIG) $(@:_config=) ppc mpc8xx v37

wtk_config:	unconfig
	@mkdir -p $(obj)include
	@echo "#define CONFIG_LCD" >$(obj)include/config.h
	@echo "#define CONFIG_SHARP_LQ065T9DR51U" >>$(obj)include/config.h
	@$(MKCONFIG) -a TQM823L ppc mpc8xx tqm8xx

#########################################################################
## PPC4xx Systems
#########################################################################
xtract_4xx = $(subst _25,,$(subst _33,,$(subst _BA,,$(subst _ME,,$(subst _HI,,$(subst _config,,$1))))))

ADCIOP_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc ppc4xx adciop esd

AP1000_config:unconfig
	@$(MKCONFIG) $(@:_config=) ppc ppc4xx ap1000 amirix

APC405_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc ppc4xx apc405 esd

AR405_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc ppc4xx ar405 esd

ASH405_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc ppc4xx ash405 esd

bamboo_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc ppc4xx bamboo amcc

bubinga_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc ppc4xx bubinga amcc

CANBT_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc ppc4xx canbt esd

CATcenter_config	\
CATcenter_25_config	\
CATcenter_33_config:	unconfig
	@mkdir -p $(obj)include
	@ echo "/* CATcenter uses PPChameleon Model ME */"  > $(obj)include/config.h
	@ echo "#define CONFIG_PPCHAMELEON_MODULE_MODEL 1" >> $(obj)include/config.h
	@[ -z "$(findstring _25,$@)" ] || \
		{ echo "#define CONFIG_PPCHAMELEON_CLK_25" >> $(obj)include/config.h ; \
		  echo "SysClk = 25MHz" ; \
		}
	@[ -z "$(findstring _33,$@)" ] || \
		{ echo "#define CONFIG_PPCHAMELEON_CLK_33" >> $(obj)include/config.h ; \
		  echo "SysClk = 33MHz" ; \
		}
	@$(MKCONFIG) -a $(call xtract_4xx,$@) ppc ppc4xx PPChameleonEVB dave

CPCI2DP_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc ppc4xx cpci2dp esd

CPCI405_config	\
CPCI4052_config	\
CPCI405DT_config	\
CPCI405AB_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc ppc4xx cpci405 esd
	@echo "BOARD_REVISION = $(@:_config=)"	>> $(obj)include/config.mk

CPCI440_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc ppc4xx cpci440 esd

CPCIISER4_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc ppc4xx cpciiser4 esd

CRAYL1_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc ppc4xx L1 cray

csb272_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc ppc4xx csb272

csb472_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc ppc4xx csb472

DASA_SIM_config: unconfig
	@$(MKCONFIG) $(@:_config=) ppc ppc4xx dasa_sim esd

DP405_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc ppc4xx dp405 esd

DU405_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc ppc4xx du405 esd

ebony_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc ppc4xx ebony amcc

ERIC_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc ppc4xx eric

EXBITGEN_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc ppc4xx exbitgen

G2000_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc ppc4xx g2000

HH405_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc ppc4xx hh405 esd

HUB405_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc ppc4xx hub405 esd

JSE_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc ppc4xx jse

KAREF_config: unconfig
	@$(MKCONFIG) $(@:_config=) ppc ppc4xx karef sandburst

luan_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc ppc4xx luan amcc

METROBOX_config: unconfig
	@$(MKCONFIG) $(@:_config=) ppc ppc4xx metrobox sandburst

MIP405_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc ppc4xx mip405 mpl

MIP405T_config:	unconfig
	@mkdir -p $(obj)include
	@echo "#define CONFIG_MIP405T" >$(obj)include/config.h
	@echo "Enable subset config for MIP405T"
	@$(MKCONFIG) -a MIP405 ppc ppc4xx mip405 mpl

ML2_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc ppc4xx ml2

ml300_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc ppc4xx ml300 xilinx

ocotea_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc ppc4xx ocotea amcc

OCRTC_config		\
ORSG_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc ppc4xx ocrtc esd

p3p440_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc ppc4xx p3p440 prodrive

PCI405_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc ppc4xx pci405 esd

pcs440ep_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc ppc4xx pcs440ep

PIP405_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc ppc4xx pip405 mpl

PLU405_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc ppc4xx plu405 esd

PMC405_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc ppc4xx pmc405 esd

PPChameleonEVB_config		\
PPChameleonEVB_BA_25_config	\
PPChameleonEVB_ME_25_config	\
PPChameleonEVB_HI_25_config	\
PPChameleonEVB_BA_33_config	\
PPChameleonEVB_ME_33_config	\
PPChameleonEVB_HI_33_config:	unconfig
	@mkdir -p $(obj)include
	@ >$(obj)include/config.h
	@[ -z "$(findstring EVB_BA,$@)" ] || \
		{ echo "#define CONFIG_PPCHAMELEON_MODULE_MODEL 0" >>$(obj)include/config.h ; \
		  echo "... BASIC model" ; \
		}
	@[ -z "$(findstring EVB_ME,$@)" ] || \
		{ echo "#define CONFIG_PPCHAMELEON_MODULE_MODEL 1" >>$(obj)include/config.h ; \
		  echo "... MEDIUM model" ; \
		}
	@[ -z "$(findstring EVB_HI,$@)" ] || \
		{ echo "#define CONFIG_PPCHAMELEON_MODULE_MODEL 2" >>$(obj)include/config.h ; \
		  echo "... HIGH-END model" ; \
		}
	@[ -z "$(findstring _25,$@)" ] || \
		{ echo "#define CONFIG_PPCHAMELEON_CLK_25" >>$(obj)include/config.h ; \
		  echo "SysClk = 25MHz" ; \
		}
	@[ -z "$(findstring _33,$@)" ] || \
		{ echo "#define CONFIG_PPCHAMELEON_CLK_33" >>$(obj)include/config.h ; \
		  echo "SysClk = 33MHz" ; \
		}
	@$(MKCONFIG) -a $(call xtract_4xx,$@) ppc ppc4xx PPChameleonEVB dave

rainier_config:	unconfig
	@mkdir -p $(obj)include
	@echo "#define CONFIG_RAINIER" > $(obj)include/config.h
	@echo "Configuring for rainier board as subset of sequoia..."
	@$(MKCONFIG) -a sequoia ppc ppc4xx sequoia amcc

rainier_nand_config:	unconfig
	@mkdir -p $(obj)include
	@mkdir -p $(obj)nand_spl
	@mkdir -p $(obj)board/amcc/sequoia
	@echo "#define CONFIG_RAINIER" > $(obj)include/config.h
	@echo "Configuring for rainier board as subset of sequoia..."
	@echo "#define CONFIG_NAND_U_BOOT" >> $(obj)include/config.h
	@echo "Compile NAND boot image for sequoia"
	@$(MKCONFIG) -a sequoia ppc ppc4xx sequoia amcc
	@echo "TEXT_BASE = 0x01000000" > $(obj)board/amcc/sequoia/config.tmp
	@echo "CONFIG_NAND_U_BOOT = y" >> $(obj)include/config.mk

sbc405_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc ppc4xx sbc405

sequoia_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc ppc4xx sequoia amcc

sequoia_nand_config:	unconfig
	@mkdir -p $(obj)include
	@mkdir -p $(obj)nand_spl
	@mkdir -p $(obj)board/amcc/sequoia
	@echo "#define CONFIG_NAND_U_BOOT" > $(obj)include/config.h
	@echo "Compile NAND boot image for sequoia"
	@$(MKCONFIG) -a sequoia ppc ppc4xx sequoia amcc
	@echo "TEXT_BASE = 0x01000000" > $(obj)board/amcc/sequoia/config.tmp
	@echo "CONFIG_NAND_U_BOOT = y" >> $(obj)include/config.mk

sycamore_config:	unconfig
	@echo "Configuring for sycamore board as subset of walnut..."
	@$(MKCONFIG) -a walnut ppc ppc4xx walnut amcc

VOH405_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc ppc4xx voh405 esd

VOM405_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc ppc4xx vom405 esd

CMS700_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc ppc4xx cms700 esd

W7OLMC_config	\
W7OLMG_config: unconfig
	@$(MKCONFIG) $(@:_config=) ppc ppc4xx w7o

walnut_config: unconfig
	@$(MKCONFIG) $(@:_config=) ppc ppc4xx walnut amcc

WUH405_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc ppc4xx wuh405 esd

XPEDITE1K_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc ppc4xx xpedite1k

yosemite_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc ppc4xx yosemite amcc

yellowstone_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc ppc4xx yellowstone amcc

yucca_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc ppc4xx yucca amcc

#########################################################################
## MPC8220 Systems
#########################################################################

Alaska8220_config	\
Yukon8220_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc8220 alaska

sorcery_config:		unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc8220 sorcery

#########################################################################
## MPC824x Systems
#########################################################################
xtract_82xx = $(subst _BIGFLASH,,$(subst _ROMBOOT,,$(subst _L2,,$(subst _266MHz,,$(subst _300MHz,,$(subst _config,,$1))))))

A3000_config: unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc824x a3000

barco_config: unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc824x barco

BMW_config: unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc824x bmw

CPC45_config	\
CPC45_ROMBOOT_config:	unconfig
	@$(MKCONFIG) $(call xtract_82xx,$@) ppc mpc824x cpc45
	@cd $(obj)include ;				\
	if [ "$(findstring _ROMBOOT_,$@)" ] ; then \
		echo "CONFIG_BOOT_ROM = y" >> config.mk ; \
		echo "... booting from 8-bit flash" ; \
	else \
		echo "CONFIG_BOOT_ROM = n" >> config.mk ; \
		echo "... booting from 64-bit flash" ; \
	fi; \
	echo "export CONFIG_BOOT_ROM" >> config.mk;

CU824_config: unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc824x cu824

debris_config: unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc824x debris etin

eXalion_config: unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc824x eXalion

HIDDEN_DRAGON_config: unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc824x hidden_dragon

kvme080_config: unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc824x kvme080 etin

MOUSSE_config: unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc824x mousse

MUSENKI_config: unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc824x musenki

MVBLUE_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc824x mvblue

OXC_config: unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc824x oxc

PN62_config: unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc824x pn62

Sandpoint8240_config: unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc824x sandpoint

Sandpoint8245_config: unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc824x sandpoint

sbc8240_config: unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc824x sbc8240

SL8245_config: unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc824x sl8245

utx8245_config: unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc824x utx8245

#########################################################################
## MPC8260 Systems
#########################################################################

atc_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc8260 atc

cogent_mpc8260_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc8260 cogent

CPU86_config	\
CPU86_ROMBOOT_config: unconfig
	@$(MKCONFIG) $(call xtract_82xx,$@) ppc mpc8260 cpu86
	@cd $(obj)include ;				\
	if [ "$(findstring _ROMBOOT_,$@)" ] ; then \
		echo "CONFIG_BOOT_ROM = y" >> config.mk ; \
		echo "... booting from 8-bit flash" ; \
	else \
		echo "CONFIG_BOOT_ROM = n" >> config.mk ; \
		echo "... booting from 64-bit flash" ; \
	fi; \
	echo "export CONFIG_BOOT_ROM" >> config.mk;

CPU87_config	\
CPU87_ROMBOOT_config: unconfig
	@$(MKCONFIG) $(call xtract_82xx,$@) ppc mpc8260 cpu87
	@cd $(obj)include ;				\
	if [ "$(findstring _ROMBOOT_,$@)" ] ; then \
		echo "CONFIG_BOOT_ROM = y" >> config.mk ; \
		echo "... booting from 8-bit flash" ; \
	else \
		echo "CONFIG_BOOT_ROM = n" >> config.mk ; \
		echo "... booting from 64-bit flash" ; \
	fi; \
	echo "export CONFIG_BOOT_ROM" >> config.mk;

ep8248_config	\
ep8248E_config	:	unconfig
	@$(MKCONFIG) ep8248 ppc mpc8260 ep8248

ep8260_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc8260 ep8260

ep82xxm_config:	unconfig
	@./mkconfig $(@:_config=) ppc mpc8260 ep82xxm

gw8260_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc8260 gw8260

hymod_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc8260 hymod

IDS8247_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc8260 ids8247

IPHASE4539_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc8260 iphase4539

ISPAN_config		\
ISPAN_REVB_config:	unconfig
	@mkdir -p $(obj)include
	@if [ "$(findstring _REVB_,$@)" ] ; then \
		echo "#define CFG_REV_B" > $(obj)include/config.h ; \
	fi
	@$(MKCONFIG) -a ISPAN ppc mpc8260 ispan

MPC8260ADS_config	\
MPC8260ADS_lowboot_config	\
MPC8260ADS_33MHz_config	\
MPC8260ADS_33MHz_lowboot_config	\
MPC8260ADS_40MHz_config	\
MPC8260ADS_40MHz_lowboot_config	\
MPC8272ADS_config	\
MPC8272ADS_lowboot_config	\
PQ2FADS_config		\
PQ2FADS_lowboot_config		\
PQ2FADS-VR_config	\
PQ2FADS-VR_lowboot_config	\
PQ2FADS-ZU_config	\
PQ2FADS-ZU_lowboot_config	\
PQ2FADS-ZU_66MHz_config	\
PQ2FADS-ZU_66MHz_lowboot_config	\
	:		unconfig
	@mkdir -p $(obj)include
	@mkdir -p $(obj)board/mpc8260ads
	$(if $(findstring PQ2FADS,$@), \
	@echo "#define CONFIG_ADSTYPE CFG_PQ2FADS" > $(obj)include/config.h, \
	@echo "#define CONFIG_ADSTYPE CFG_"$(subst MPC,,$(word 1,$(subst _, ,$@))) > $(obj)include/config.h)
	$(if $(findstring MHz,$@), \
	@echo "#define CONFIG_8260_CLKIN" $(subst MHz,,$(word 2,$(subst _, ,$@)))"000000" >> $(obj)include/config.h, \
	$(if $(findstring VR,$@), \
	@echo "#define CONFIG_8260_CLKIN 66000000" >> $(obj)include/config.h))
	@[ -z "$(findstring lowboot_,$@)" ] || \
		{ echo "TEXT_BASE = 0xFF800000" >$(obj)board/mpc8260ads/config.tmp ; \
		  echo "... with lowboot configuration" ; \
		}
	@$(MKCONFIG) -a MPC8260ADS ppc mpc8260 mpc8260ads

MPC8266ADS_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc8260 mpc8266ads

# PM825/PM826 default configuration:  small (= 8 MB) Flash / boot from 64-bit flash
PM825_config	\
PM825_ROMBOOT_config	\
PM825_BIGFLASH_config	\
PM825_ROMBOOT_BIGFLASH_config	\
PM826_config	\
PM826_ROMBOOT_config	\
PM826_BIGFLASH_config	\
PM826_ROMBOOT_BIGFLASH_config:	unconfig
	@mkdir -p $(obj)include
	@mkdir -p $(obj)board/pm826
	@if [ "$(findstring PM825_,$@)" ] ; then \
		echo "#define CONFIG_PCI"	>$(obj)include/config.h ; \
	else \
		>$(obj)include/config.h ; \
	fi
	@if [ "$(findstring _ROMBOOT_,$@)" ] ; then \
		echo "... booting from 8-bit flash" ; \
		echo "#define CONFIG_BOOT_ROM" >>$(obj)include/config.h ; \
		echo "TEXT_BASE = 0xFF800000" >$(obj)board/pm826/config.tmp ; \
		if [ "$(findstring _BIGFLASH_,$@)" ] ; then \
			echo "... with 32 MB Flash" ; \
			echo "#define CONFIG_FLASH_32MB" >>$(obj)include/config.h ; \
		fi; \
	else \
		echo "... booting from 64-bit flash" ; \
		if [ "$(findstring _BIGFLASH_,$@)" ] ; then \
			echo "... with 32 MB Flash" ; \
			echo "#define CONFIG_FLASH_32MB" >>$(obj)include/config.h ; \
			echo "TEXT_BASE = 0x40000000" >$(obj)board/pm826/config.tmp ; \
		else \
			echo "TEXT_BASE = 0xFF000000" >$(obj)board/pm826/config.tmp ; \
		fi; \
	fi
	@$(MKCONFIG) -a PM826 ppc mpc8260 pm826

PM828_config	\
PM828_PCI_config	\
PM828_ROMBOOT_config	\
PM828_ROMBOOT_PCI_config:	unconfig
	@mkdir -p $(obj)include
	@mkdir -p $(obj)board/pm826
	@if [ "$(findstring _PCI_,$@)" ] ; then \
		echo "#define CONFIG_PCI"  >>$(obj)include/config.h ; \
		echo "... with PCI enabled" ; \
	else \
		>$(obj)include/config.h ; \
	fi
	@if [ "$(findstring _ROMBOOT_,$@)" ] ; then \
		echo "... booting from 8-bit flash" ; \
		echo "#define CONFIG_BOOT_ROM" >>$(obj)include/config.h ; \
		echo "TEXT_BASE = 0xFF800000" >$(obj)board/pm826/config.tmp ; \
	fi
	@$(MKCONFIG) -a PM828 ppc mpc8260 pm828

ppmc8260_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc8260 ppmc8260

Rattler8248_config	\
Rattler_config:		unconfig
	@mkdir -p $(obj)include
	$(if $(findstring 8248,$@), \
	@echo "#define CONFIG_MPC8248" > $(obj)include/config.h)
	@$(MKCONFIG) -a Rattler ppc mpc8260 rattler

RPXsuper_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc8260 rpxsuper

rsdproto_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc8260 rsdproto

sacsng_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc8260 sacsng

sbc8260_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc8260 sbc8260

SCM_config:		unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc8260 SCM siemens

TQM8255_AA_config \
TQM8260_AA_config \
TQM8260_AB_config \
TQM8260_AC_config \
TQM8260_AD_config \
TQM8260_AE_config \
TQM8260_AF_config \
TQM8260_AG_config \
TQM8260_AH_config \
TQM8260_AI_config \
TQM8265_AA_config:  unconfig
	@mkdir -p $(obj)include
	@case "$@" in \
	TQM8255_AA_config) CTYPE=MPC8255; CFREQ=300; CACHE=no;	BMODE=8260;;  \
	TQM8260_AA_config) CTYPE=MPC8260; CFREQ=200; CACHE=no;	BMODE=8260;; \
	TQM8260_AB_config) CTYPE=MPC8260; CFREQ=200; CACHE=yes;	BMODE=60x;;  \
	TQM8260_AC_config) CTYPE=MPC8260; CFREQ=200; CACHE=yes;	BMODE=60x;;  \
	TQM8260_AD_config) CTYPE=MPC8260; CFREQ=300; CACHE=no;	BMODE=60x;;  \
	TQM8260_AE_config) CTYPE=MPC8260; CFREQ=266; CACHE=no;	BMODE=8260;; \
	TQM8260_AF_config) CTYPE=MPC8260; CFREQ=300; CACHE=no;	BMODE=60x;;  \
	TQM8260_AG_config) CTYPE=MPC8260; CFREQ=300; CACHE=no;	BMODE=8260;; \
	TQM8260_AH_config) CTYPE=MPC8260; CFREQ=300; CACHE=yes;	BMODE=60x;;  \
	TQM8260_AI_config) CTYPE=MPC8260; CFREQ=300; CACHE=no;	BMODE=60x;;  \
	TQM8265_AA_config) CTYPE=MPC8265; CFREQ=300; CACHE=no;	BMODE=60x;;  \
	esac; \
	>$(obj)include/config.h ; \
	if [ "$${CTYPE}" != "MPC8260" ] ; then \
		echo "#define CONFIG_$${CTYPE}"	>>$(obj)include/config.h ; \
	fi; \
	echo "#define CONFIG_$${CFREQ}MHz"	>>$(obj)include/config.h ; \
	echo "... with $${CFREQ}MHz system clock" ; \
	if [ "$${CACHE}" == "yes" ] ; then \
		echo "#define CONFIG_L2_CACHE"	>>$(obj)include/config.h ; \
		echo "... with L2 Cache support" ; \
	else \
		echo "#undef CONFIG_L2_CACHE"	>>$(obj)include/config.h ; \
		echo "... without L2 Cache support" ; \
	fi; \
	if [ "$${BMODE}" == "60x" ] ; then \
		echo "#define CONFIG_BUSMODE_60x" >>$(obj)include/config.h ; \
		echo "... with 60x Bus Mode" ; \
	else \
		echo "#undef CONFIG_BUSMODE_60x"  >>$(obj)include/config.h ; \
		echo "... without 60x Bus Mode" ; \
	fi
	@$(MKCONFIG) -a TQM8260 ppc mpc8260 tqm8260

VoVPN-GW_66MHz_config	\
VoVPN-GW_100MHz_config:		unconfig
	@mkdir -p $(obj)include
	@echo "#define CONFIG_CLKIN_$(word 2,$(subst _, ,$@))" > $(obj)include/config.h
	@$(MKCONFIG) -a VoVPN-GW ppc mpc8260 vovpn-gw funkwerk

ZPC1900_config: unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc8260 zpc1900

#########################################################################
## Coldfire
#########################################################################

cobra5272_config :		unconfig
	@$(MKCONFIG) $(@:_config=) m68k mcf52x2 cobra5272

EB+MCF-EV123_config :		unconfig
	@mkdir -p $(obj)include
	@mkdir -p $(obj)board/BuS/EB+MCF-EV123
	@ >$(obj)include/config.h
	@echo "TEXT_BASE = 0xFFE00000"|tee $(obj)board/BuS/EB+MCF-EV123/textbase.mk
	@$(MKCONFIG) EB+MCF-EV123 m68k mcf52x2 EB+MCF-EV123 BuS

EB+MCF-EV123_internal_config :	unconfig
	@mkdir -p $(obj)include
	@mkdir -p $(obj)board/BuS/EB+MCF-EV123
	@ >$(obj)include/config.h
	@echo "TEXT_BASE = 0xF0000000"|tee $(obj)board/BuS/EB+MCF-EV123/textbase.mk
	@$(MKCONFIG) EB+MCF-EV123 m68k mcf52x2 EB+MCF-EV123 BuS

M5271EVB_config :		unconfig
	@$(MKCONFIG) $(@:_config=) m68k mcf52x2 m5271evb

M5272C3_config :		unconfig
	@$(MKCONFIG) $(@:_config=) m68k mcf52x2 m5272c3

M5282EVB_config :		unconfig
	@$(MKCONFIG) $(@:_config=) m68k mcf52x2 m5282evb

TASREG_config :		unconfig
	@$(MKCONFIG) $(@:_config=) m68k mcf52x2 tasreg esd

r5200_config :		unconfig
	@$(MKCONFIG) $(@:_config=) m68k mcf52x2 r5200

#########################################################################
## MPC83xx Systems
#########################################################################

MPC8349ADS_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc83xx mpc8349ads

TQM834x_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc83xx tqm834x

MPC8349EMDS_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc83xx mpc8349emds

#########################################################################
## MPC85xx Systems
#########################################################################

MPC8540ADS_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc85xx mpc8540ads

MPC8540EVAL_config \
MPC8540EVAL_33_config \
MPC8540EVAL_66_config \
MPC8540EVAL_33_slave_config \
MPC8540EVAL_66_slave_config:      unconfig
	@mkdir -p $(obj)include
	@echo "" >$(obj)include/config.h ; \
	if [ "$(findstring _33_,$@)" ] ; then \
		echo -n "... 33 MHz PCI" ; \
	else \
		echo "#define CONFIG_SYSCLK_66M" >>$(obj)include/config.h ; \
		echo -n "... 66 MHz PCI" ; \
	fi ; \
	if [ "$(findstring _slave_,$@)" ] ; then \
		echo "#define CONFIG_PCI_SLAVE" >>$(obj)include/config.h ; \
		echo " slave" ; \
	else \
		echo " host" ; \
	fi
	@$(MKCONFIG) -a MPC8540EVAL ppc mpc85xx mpc8540eval

MPC8560ADS_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc85xx mpc8560ads

MPC8541CDS_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc85xx mpc8541cds cds

MPC8548CDS_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc85xx mpc8548cds cds

MPC8555CDS_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc85xx mpc8555cds cds

PM854_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc85xx pm854

PM856_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc85xx pm856

sbc8540_config \
sbc8540_33_config \
sbc8540_66_config:	unconfig
	@mkdir -p $(obj)include
	@if [ "$(findstring _66_,$@)" ] ; then \
		echo "#define CONFIG_PCI_66"	>>$(obj)include/config.h ; \
		echo "... 66 MHz PCI" ; \
	else \
		>$(obj)include/config.h ; \
		echo "... 33 MHz PCI" ; \
	fi
	@$(MKCONFIG) -a SBC8540 ppc mpc85xx sbc8560

sbc8560_config \
sbc8560_33_config \
sbc8560_66_config:      unconfig
	@mkdir -p $(obj)include
	@if [ "$(findstring _66_,$@)" ] ; then \
		echo "#define CONFIG_PCI_66"	>>$(obj)include/config.h ; \
		echo "... 66 MHz PCI" ; \
	else \
		>$(obj)include/config.h ; \
		echo "... 33 MHz PCI" ; \
	fi
	@$(MKCONFIG) -a sbc8560 ppc mpc85xx sbc8560

stxgp3_config:		unconfig
	@$(MKCONFIG) $(@:_config=) ppc mpc85xx stxgp3

TQM8540_config		\
TQM8541_config		\
TQM8555_config		\
TQM8560_config:		unconfig
	@mkdir -p $(obj)include
	@CTYPE=$(subst TQM,,$(@:_config=)); \
	>$(obj)include/config.h ; \
	echo "... TQM"$${CTYPE}; \
	echo "#define CONFIG_MPC$${CTYPE}">>$(obj)include/config.h; \
	echo "#define CONFIG_TQM$${CTYPE}">>$(obj)include/config.h; \
	echo "#define CONFIG_HOSTNAME tqm$${CTYPE}">>$(obj)include/config.h; \
	echo "#define CONFIG_BOARDNAME \"TQM$${CTYPE}\"">>$(obj)include/config.h; \
	echo "#define CFG_BOOTFILE \"bootfile=/tftpboot/tqm$${CTYPE}/uImage\0\"">>$(obj)include/config.h
	@$(MKCONFIG) -a TQM85xx ppc mpc85xx tqm85xx

#########################################################################
## MPC86xx Systems
#########################################################################

MPC8641HPCN_config:    unconfig
	@./mkconfig $(@:_config=) ppc mpc86xx mpc8641hpcn


#########################################################################
## 74xx/7xx Systems
#########################################################################

AmigaOneG3SE_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc 74xx_7xx AmigaOneG3SE MAI

BAB7xx_config: unconfig
	@$(MKCONFIG) $(@:_config=) ppc 74xx_7xx bab7xx eltec

CPCI750_config:        unconfig
	@$(MKCONFIG) CPCI750 ppc 74xx_7xx cpci750 esd

DB64360_config:  unconfig
	@$(MKCONFIG) DB64360 ppc 74xx_7xx db64360 Marvell

DB64460_config:  unconfig
	@$(MKCONFIG) DB64460 ppc 74xx_7xx db64460 Marvell

ELPPC_config: unconfig
	@$(MKCONFIG) $(@:_config=) ppc 74xx_7xx elppc eltec

EVB64260_config	\
EVB64260_750CX_config:	unconfig
	@$(MKCONFIG) EVB64260 ppc 74xx_7xx evb64260

P3G4_config: unconfig
	@$(MKCONFIG) $(@:_config=) ppc 74xx_7xx evb64260

PCIPPC2_config \
PCIPPC6_config: unconfig
	@$(MKCONFIG) $(@:_config=) ppc 74xx_7xx pcippc2

ZUMA_config:	unconfig
	@$(MKCONFIG) $(@:_config=) ppc 74xx_7xx evb64260

ppmc7xx_config: unconfig
	@$(MKCONFIG) $(@:_config=) ppc 74xx_7xx ppmc7xx

#========================================================================
# ARM
#========================================================================
#########################################################################
## StrongARM Systems
#########################################################################

assabet_config	:	unconfig
	@$(MKCONFIG) $(@:_config=) arm sa1100 assabet

dnp1110_config	:	unconfig
	@$(MKCONFIG) $(@:_config=) arm sa1100 dnp1110

gcplus_config	:	unconfig
	@$(MKCONFIG) $(@:_config=) arm sa1100 gcplus

lart_config	:	unconfig
	@$(MKCONFIG) $(@:_config=) arm sa1100 lart

shannon_config	:	unconfig
	@$(MKCONFIG) $(@:_config=) arm sa1100 shannon

#########################################################################
## ARM92xT Systems
#########################################################################

xtract_trab = $(subst _bigram,,$(subst _bigflash,,$(subst _old,,$(subst _config,,$1))))

xtract_omap1610xxx = $(subst _cs0boot,,$(subst _cs3boot,,$(subst _cs_autoboot,,$(subst _config,,$1))))

xtract_omap730p2 = $(subst _cs0boot,,$(subst _cs3boot,, $(subst _config,,$1)))


