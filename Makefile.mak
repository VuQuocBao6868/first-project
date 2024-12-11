# project setting

TARGET = fist_make
MCU = atmega328p
F_CPU = 16000000UL  # it mean the chip will run 16 million clock cycles per second
PORT = /dev/ttyACM0
PROGRAMMER = anhbaodeptrai
BRAURATE = 9200

# complier setting

CC = avr-gcc # this is complier for arduino but for esp32 that is elf
OBJCOPY = avr-objcopy  # this is variable which is use to store variable's data of .hex file 
# when I convert .elf file to .hex file
CFLASS = -Wall -Os -mmcu=$(MCU) -DR_CPU=$(F_CPU)
# this use to give a warning that is useful when I debug 
# optimize for size file .hex when convert
# tell the complier is compling program for atmega
# final step that define the speed for CPU when it excuted program to chip
AVRDUDE = avrdude
AVRDUDE_FLAGS = -v -p $(MCU) -c $(PROGRAMMER) - P $(PORT) -b $(BRAURATE)

# setting source file we need to complie
SRC = a.c



# at this step I will creat Targets and rule for run program

# to create a file which can charge of into chip AVR I will convert from .c file to .hex file
# .c -> .o (or object file, library)
# .o -> .elf (elf is excutable library file)
# .elf -> .hex (.hex is final file to charge of into chip)

all: $(TARGET).hex

%.o: %.c
	$(CC) $(CFLASS) -c $< -o $@

$(TARGET).elf: $(SRC)
	$(CC) $(CFLASS) -o $@ $^

$(TARGET).hex: $(TARGET).elf
	$(OBJCOPY) -O ihex -R .eeprom $< $@

flash: $(TARGET)
	$(AVRDUDE) $(AVRDUDE_FLAGS) -U flash:w:$<:i
	
clean:
	rm -f $(SRC) $(TARGET).elf $(TARGET).hex

.PHONY:all flash clean
