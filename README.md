# introduction-to-assembly
My first program in Assembly: a coin changer program

The program is an exercise about the following situation: "The Automatic Seller Machine (ASM) company developed an automatic product sales machine and intends to make this machine available on the Brazilian market.

The equipment's hardware is already developed, and your company was hired to develop the software, in assembly language, for the equipment to function.

The hardware is based on the MIPS 32-bit architecture and has equipment that accepts banknotes of 20, 10, 5 and 2 reais, as well as coins of 1 real and 50, 25 and 10 cents.

The software to be developed will receive the number of banknotes and coins inserted and must:

• Inform on the display the amount of money inserted.

• Inform the price of the selected product on the display.

• Inform the display of the change value.

• Calculate the quantity of each banknote and currency that must be provided as change, optimizing so that the quantity of the banknote / currency is the minimum possible (always supply as much change as possible the highest amount of notes and coins).

Example: If a product that costs R$ 3.50 to be paid with a R$ 20.00 note, the change of R$ 16.50 cannot be paid with 3 notes of R$ 5.00 and 3 coins of R$ 0.50. It must be paid with 1 note of R$ 10.00, 1 note of R$ 5.00, 1 coin of R$ 1.00 and a coin of R$ 0.50."

Obs: there is any input in the program. You have to define the money inserted and the price in the registers. The following ones:

•$s0 Number of R$20,00 notes inserted.

•$s0 Number of R$10,00 notes inserted.

•$s0 Number of R$5,00 notes inserted.

•$s0 Number of R$2,00 notes inserted.

•$s0 Number of R$1,00 coins inserted.

•$s0 Number of R$0,50 coins inserted.

•$s0 Number of R$0,25 coins inserted.

•$s0 Number of R$0,10 coins inserted.

•$t9 Product price × 100.

They will be also updated to the change value:

•$s0 Number of R$20,00 notes to the change value.

•$s0 Number of R$10,00 notes to the change value.

•$s0 Number of R$5,00 notes to the change value.

•$s0 Number of R$2,00 notes to the change value.

•$s0 Number of R$1,00 coins to the change value.

•$s0 Number of R$0,50 coins to the change value.

•$s0 Number of R$0,25 coins to the change value.

•$s0 Number of R$0,10 coins to the change value.

•$t9 Number of R$0,05 coins to the change value.


