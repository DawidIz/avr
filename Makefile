MCU = atmega8
PROGRAMMER = usbasp
FILES = main.c

all: elf hex flash

elf:
	avr-gcc -g -Os -mmcu=$(MCU) -o main.elf $(FILES)
	
hex: elf
	avr-objcopy -j .text -j .data -O ihex main.elf main.hex
	
flash:
	sudo avrdude -p $(MCU) -B 3 -c $(PROGRAMMER) -U flash:w:main.hex 
	
clean:
	@rm *.elf *.hex