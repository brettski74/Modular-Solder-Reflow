# Power Section Design

This directory contains a design for the main power control section of a reflow hotplate. The design is based on a buck converter with a low side switch. It includes current sensing via two INA180 current sense amplifiers. The PWM signal is provided externally. The main goals of the current design are:

  - Verify the design works.
  - Reduce current ripple and voltage spikes to manageable levels.
  - Allow high frequency operation without making input capacitors or other components excessively hot.
  - Allow testing of different microcontroller, screen and UI combinations with a working power section.
  - Provide up to 100W of output power.
  - Be able to operate from power supplies ranging from 12V to 20V DC.

## Theory Of Operation

In addition to the main power input, this board expects a PWM signal at a frequency between 60kHz and 200kHz. The gate drive circuitry is inverting, so the PWM pin is active low. Users must bear this in mind when developing software to control this board. The PWM signal can operate on 3.3V or 5V. It is first fed into MOSFET Q1, which provides level shifting in conjunction with R5. This pulls the PWM signal up to near the main power supply voltage. This is one of the reasons for the 20V upper limit on the input voltage. Most MOSFETs are limited to about 20V on their gate.

The level shifted PWM signal is then fed into a totem pole gate driver (U4) to drive larger currents into Q2's gate. Q2 is the main MOSFET switch. When the PWM signal goes low, Q2's gate is driven high, turning it on. Once Q2 turns on, it pulls current through the heating element and L2. When the PWM signal goes high again, Q2's gate is pulled low, turning it off. Diode D3 now starts to conduct providing a conduction path for the current in L2. L2 limits current ripple in the heater circuit. Capacitor C9 reduces voltage ripple.

C8 and R10 form an RC snubber across the main MOSFET switch. Component values are approximate and not specifically tuned for this design yet. That said, it is expected that they should function adequately for the task. There is also an RC snubber across D3 formed by R8 and C7.

Resistors R11, R12 and R13 form a current shunt for measuring the current through the heating element. The three 45m$\Omega$ resistors form a 15m$\Omega$ shunt. These resistors should have a low temperature coefficient of resistance. Three 2W resistors are specified to provide ample headroom to dissipate heat when operating at high currents - as may be necessary for 12V supplies.

The design includes two current sense amplifiers with different gains to allow for full range current sensing while also allowing higher resolution at lower currents. The current sense amplifier outputs have a low pass filter on their outputs formed by R1/C3 and R2/C4. As designed, these have a corner frequency at about 1.6kHz. It is assumed that PID control would use a sample frequency somewhere in the vicinity of 20-50Hz,

The input currently includes a 10 amp fuse to protect against overcurrent faults. It also includes an input LC filter to help limit upstream impacts from the operation of the heater control.

## Optional Components

The RC snubbers formed by C8/R10 and C7/R8 are not entirely necessary for the ciruit to work, however, they should reduce ringing and other transient effects from the high frequency switching of large currents.

Diode D1 provides a lower impedance path for discharge Q2's gate at turn-off time. While this is usually desirable, the circuit will likely work ok without it.

If you have no intention of measuring the heater current, you can omit the INA180 current sense amplified and associated buffer and filter components. You do need to either include R11, R12 and R13 or alternatively short them with some wire suitable for the current you expect to drive with this board.

Inductor L1 may not ne necessary. It's main purpose is to reduce the amount of noise fed back to the upstream power supply, however, the board will likely work relatively fine without it. If not used, simply short the contacts for L2 with some wire.

## 3D Models

To render a 3D representation of the board and components, some of the footprints require 3D models that are not available with KiCad and are also not included in the git repository. There are freely available 3D models for these components, but since I'm not sure of the licensing of these models, I'm reluctant to include them and effectively be redistributing them in my git repository. Instead, I've included a shell script in the 3d subdirectory that will download the models from publicly accessible locations on the web for you to use for your own needs. If you don't care about a 3D rendering of the board and components, then you don't need these 3D models.

