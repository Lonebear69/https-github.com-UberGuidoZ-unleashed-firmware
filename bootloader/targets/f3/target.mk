TOOLCHAIN = arm

BOOT_ADDRESS	= 0x08000000
FW_ADDRESS		= 0x08008000
OS_OFFSET		= 0x00008000
FLASH_ADDRESS	= 0x08000000

DEBUG_AGENT		= openocd -f interface/stlink.cfg -c "transport select hla_swd" -f target/stm32wbx.cfg -c "init" -c "adapter speed 4000"
BOOT_CFLAGS		= -DBOOT_ADDRESS=$(BOOT_ADDRESS) -DFW_ADDRESS=$(FW_ADDRESS) -DOS_OFFSET=$(OS_OFFSET)
MCU_FLAGS		= -mcpu=cortex-m4 -mthumb -mfpu=fpv4-sp-d16 -mfloat-abi=hard

CFLAGS			+= $(MCU_FLAGS) $(BOOT_CFLAGS) -DSTM32WB55xx -Wall -fdata-sections -ffunction-sections
LDFLAGS			+= $(MCU_FLAGS) -specs=nosys.specs -specs=nano.specs

CUBE_DIR		= ../lib/STM32CubeWB

ASM_SOURCES		+= $(CUBE_DIR)/Drivers/CMSIS/Device/ST/STM32WBxx/Source/Templates/gcc/startup_stm32wb55xx_cm4.s
C_SOURCES		+= $(CUBE_DIR)/Drivers/CMSIS/Device/ST/STM32WBxx/Source/Templates/system_stm32wbxx.c
C_SOURCES		+= $(CUBE_DIR)/Drivers/STM32WBxx_HAL_Driver/Src/stm32wbxx_ll_utils.c

CFLAGS			+= -I$(CUBE_DIR)/Drivers/CMSIS/Include
CFLAGS			+= -I$(CUBE_DIR)/Drivers/CMSIS/Device/ST/STM32WBxx/Include
CFLAGS			+= -I$(CUBE_DIR)/Drivers/STM32WBxx_HAL_Driver/Inc

LDFLAGS			+= -Ttargets/f3/stm32wb55xx_flash_cm4.ld

ASM_SOURCES		+= $(wildcard $(TARGET_DIR)/*.s)
C_SOURCES		+= $(wildcard $(TARGET_DIR)/*.c)
CPP_SOURCES		+= $(wildcard $(TARGET_DIR)/*.cpp)
