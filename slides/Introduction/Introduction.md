---
title: Introduction
subtitle: Design your Chip
theme: simple
css: hm.css
---

# What to expect

## What we cannot achieve

After this course:

- you will not be able to design a modern chip on your own

- you will not be a fully educated expert in this field

## What we want to achieve

After this course:

- you will have build a chip!

- you will know the fundamentals of chip design, use open source tools only to lower barrier

- you will look back to two weeks of fun (and some pain)

## Goals

- Understand the challenges of chip design

- Reproduce basic steps from idea to tapeout

- Work on an exciting project in a team

- Produce a chip! (limited availability)

## Format

- First two days:

  - High level overview of the entire chip design flow (classroom setting)

  - Simple project: Build a chip in an hour (or two)

- Remaining days:

  - Teams of four students formulate an idea

  - Various platforms, and support for more if needed

  - Problem-based learning: You learn what you need, depending on your current problems, and we assist you with materials and help

# The Chip

## What is a chip?

Chips are everywhere, and you find them mostly *packaged*.

. . .

Examples for packages:

![Packages](img/packages.jpg){height=50%}\

## Inside the package

Semiconductor *die* is glued and connected to the pins:

![Decap chip](img/decap.jpg){height=50%}\

## Origin of the die

Semiconductor dies are cut from wafers of multiple chips:

![Wafer](img/wafer.jpg)\

## So, what is on this die/wafer?

::: columns

:::: {.column width=60%}

Fundamental element: **Transistor**

- Basic semiconductor substrate does not conduct current
- Metal gate is separated by oxide from semiconductor
- Two doped regions contain extra electrons (source and drain)
- Once sufficient voltage is applied to gate, current can flow from source to drain

::::

:::: {.column width=40%}

![MOSFET](img/MosfetDiagram.jpg)\

::::

:::

## Transistor as switch

::: columns

:::: {.column width=60%}

Transistor switching can be used to build boolean operations.

Example: *Complementary MOS (CMOS)* **inverter**

- Transistor towards ground conducts when voltage high
- Transistor towards supply voltave conducts when voltage low

**Truth table**

| $V_{in}$ | $V_{out}$ |
| -------- | --------- |
| 0        | 1         |
| 1        | 0         |

::::

:::: {.column width=40%}

![MOSFET](img/inverter.png)\

::::

:::

## Boolean gates from transistors

::: columns

:::: {.column width=60%}

Multiple transistors can be combined to gates that implement boolean functions of multiple variables.

Example: **NAND**

| A | B | Output |
| - | - | ------ |
| 0 | 0 | 1      |
| 0 | 1 | 1      |
| 1 | 0 | 1      |
| 1 | 1 | 0      |

::::

:::: {.column width=40%}

![NAND gate](img/nand.png)\

::::

:::

## Building chips from transistors

::: columns

:::: {.column width=60%}

Chips are circuits of up to a hundred billion of transitors.

Many layers are build on the silicon substrate:

- Build individual transistors with doping, oxide and metals
- Multiple layers of metal for wiring
- Contact metal between layers

::::

:::: {.column width=40%}

![Layers](img/cmoslayers.png)\

::::

:::

## Layout from Transistor

![Layout](img/layout.png)\

## Layout of first Intel CPU

![4004](img/4004-masks-composite.jpg)\

# Manufacturing of Chips

##

![](img/micron-fabrication.jpg)

##

![](img/micron-analogy.jpg)

##

![](img/micron-steps.jpg)

##

![](img/micron-step0.jpg)

##

![](img/micron-step1.jpg)

##

![](img/micron-step2.jpg)

##

![](img/micron-step3.jpg)

##

![](img/micron-step4.jpg)

##

![](img/micron-step5.jpg)

## Repeating steps

A wafer runs through various stages, where in each:

- Material is added
- Photoresist is added
- A pattern is projected with photolithography
- Material is etched or implanted
- Photoresist is removed

Challenge with photolithography and shrinking sizes.

##

![](img/micron-photo1.jpg)

##

![](img/micron-photo2.jpg)

##

![](img/micron-photo3.jpg)

##

![](img/micron-photo4.jpg)

##

![](img/micron-photo5.jpg)

##

![](img/micron-photo6.jpg)

## The EUV challenge

The most complex machine ever built.

![](img/asml.jpg)

## ASML EUV Lithography

EUV was a challenge for many years, and only ASML currently supplies the world market.

![](img/asml-open.jpg)

## EUV light source

![](img/euv-source.png)

## Reflecting and focusing EUV to recticle

![](img/asml-reflectors.png)

# Next Steps and Projects

## Today & Tomorrow

- Brief introduction into the digital design flow
- Simple end-to-end design from idea to manufacturable chip
- Project pitching and team building

## Projects for the next two weeks

- Teams of four students
- Topics can be chosen freely
- Guidance by us on complexity
- Think about an issue that you think hardware can solve better than software

## Suggestions for topics/platforms

- Participate in the LAYR open chip design challenge
- Design a RISC-V System-on-Chip with a hardware accelerator
- Build a hardware accelerator that connects to an existing processor
- VGA demo

## LAYR

::: columns

:::: column

Challenge: Build a secure door lock chip

Students participate with other universities

Final evaluation and ceremony next year

Up to three teams can participate!

::::

:::: column

![LAYR](img/layr.jpg){ height=600px }\

::::

:::

## RISC-V System-on-Chip

::: columns

:::: { .column width=40%}

- Start from basic system-on-chip
- Run software on the processor core
- Design your own accelerator, that performs certain tasks more efficiently
- Write software that uses this hardware
- Compare measurements

::::

:::: column

![LAYR](img/croc_arch.svg){ height=300px }\

::::

:::

## Example design

::: columns

:::: { .column width=40%}

- *Hatch* chip of my research group
- RISC-V core (32-bit)
- 64kB SRAM
- Accelerator for bytecode virtualization
- 2.5x2.5mm @ 130nm
- All open source!

::::

:::: column

![LAYR](img/hatch.png){ height=300px }\

::::

:::


## Hardware Accelerator

::: columns

:::: {.column width=40%}

- Reconfigurable hardware (more tomorrow)
- Multicore system with high performance RISC-V cores
- Programmable logic for accelerators
- Similarly interact with accelerator

::::

:::: column

![LAYR](img/polarfire.png){ height=500px }\

::::

:::


## VGA demo

::: columns

:::: {.column width=40%}

- Build custom hardware that produces live images
- Creative and impressive results possible
  - Minimal hardware, complex scenes
  - Comparable demo scene some time ago
- Can also be an old school video game (you will be surprised)
- Full custom chip!

::::

:::: column

![LAYR](img/vga.png){ height=300px }\

::::

:::

## Your ideas

- Please think about your ideas already today
- Pitch your ideas tomorrow
- Teams will be formed, ideally already with topics

## Organization

- Today and tomorrow:
  - More technical input
  - Guided own first chip design
  - Breakout rooms R1.006, R1.007, R1.008, R1.009, R1.010A, R2.010, R2.012, R2.014
- Moodle: More information, coordination, etc., check mails!
- Exam: Modularbeit (portfolio)
  - 6 to 8 pages describing your project
  - Highlight your individual contribution
  - Guidelines will be discussed in the next days
  - Deadline: February 27, 2026

# Enjoy the two weeks!