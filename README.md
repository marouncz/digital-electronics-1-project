# VHDL Group project 
## Timer for circuit workout 
This is our team's repository for group project consisting of workout timer, programmed in vhdl.

![IMG_7012](https://user-images.githubusercontent.com/102173814/235366753-1821fee4-356a-424d-b57d-2666117c4c2a.jpg)

## Team members
- Marek Coufal
- Jakub Plachtička
- Tomáš Paulysko

## Theoretical description 
- Our team developed a timer for a circular workout using VHDL programming language. The timer is designed to track the time during a workout and give audio and visual feedback to the user. The timer uses a XILINX Nexys A7(Artix-7 50T) development board, which is platform for FPGA development. We implemeted an audio buzzer, RGB LED, and 8 seven-segment displays to display how much time is left, how many laps are left, and whether it's a break or exercise time.

- The timer has setup mode and run mode. The set mode allows the user to set the workout time, rest time for each round and how many laps are left until the end of workout.


## Hardware description of demo application
- This project was developed on XILINX Nexys A7(Artix-7 50T) development board. The board has several built-in peripherals, including a USB interface, audio codec, VGA output, Ethernet port, and a range of digital I/O pins. However, we are not using these board outputs as they are outside the scope of this project (except the GPIO pins).

- For our timer, we used one RGB LED and 8 seven-segment displays. The RGB LED is connected to three digital output pins and is used to provide visual feedback to the user. The seven-segment displays are connected to 24 digital output pins and are used to display the time during the workout.

- As external device we use buzzer module, so that the trainees don't have to look at the display and can focus on exercising.

On the development board we use:
- All seven-segment displays
    - To display the countdown, whether it is a break or not, and how many rounds are remaining."
- Buttons
    - To set the time for the round or break and the number of rounds.
- One RGB led 
    - For extra visual user experience.

External devices: 
- Arduino multifunction shield (we use only buzzer)

## Software description 

<img width="50%" height="50%" src="https://user-images.githubusercontent.com/102173814/235366811-ae179e49-5846-47d0-8f50-7500a98d6cf9.jpg">

- The timer is implemented using VHDL programming language. The VHDL code is divided into several modules, including the top-level module, clock divider module, seven-segment display module, audio module, and RGB LED module. The top-level module contains the main logic of the timer, which controls the flow of the program and communicates with the other modules.

- The clock divider module is responsible for generating a clock signal with a frequency of 1 Hz, which is used as a timebase for the timer. The seven-segment display module converts the time value into a format that can be displayed on the seven-segment displays. The RGB LED module controls the color of the RGB LED.

## User Instructions


## References
- [Buzzer shield guide](https://www.subsystems.us/arduino-multifunction-shield.html)
- [AMD XILINX](https://www.xilinx.com)
- [Nexys A7 50T](https://cz.farnell.com/digilent/410-292/dev-board-artix-7-fpga-nexys-ddr/dp/2490174?gclid=Cj0KCQjwgLOiBhC7ARIsAIeetVCqJjtBTyDnODIY4Nv4i9IL-F8cAWYEleMV-jqFxzXIvoAmmu4J-_8aAiqKEALw_wcB&mckv=_dc%7Cpcrid%7C%7Cplid%7C%7Ckword%7C%7Cmatch%7C%7Cslid%7C%7Cproduct%7C2490174%7Cpgrid%7C%7Cptaid%7C%7C&CMP=KNC-GCZ-GEN-SHOPPING-PMax-CLM-NCA&gross_price=true)
