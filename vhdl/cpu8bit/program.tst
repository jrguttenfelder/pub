1000100000000001 LIC 1
1000110000000000 STC 0 -- DM(0) = 1
1000100000000010 LIC 2
1000110000000001 STC 1 -- DM(1) = 2
1000000000000000 LDA 0 -- RegA = DM(0)
1000010000000001 LDB 1 -- RegB = DM(1)
1110000000000000 RDM 0 -- output DM(0)
1110000000000001 RDM 1 -- output DM(1)
1000100000000010 LIC 3
1000110011110000 STC 0xF0 -- loop variable set to 3
1000100000000001 LIC 1
1000110011110001 STC 0xF1 -- constant: increment amount set to 1
1000100000001010 LIC 10
1000110011110010 STC 0xF2 -- constant: max loop count set to 10
1000100000000000 LIC 0
1000110011110011 STC 0xF3 -- constant: zero
0000000000000000 ADD      -- start of loop
1000110000000010 STC 2    -- DM(2) = DM(0) + DM(1)
1110000000000010 RDM 2    -- output DM(2)
1000000011110000 LDA 0xF0 -- i++
1000010011110001 LDB 0xF1 
0000000000000000 ADD      
1000110011110000 STC 0xF0 
1000010011110010 LDB 0xF2 -- i < 10
1010000000000000 NOP
1010100000100101 JEQ 35   -- goto to HLT if loop is done
1000000000000001 LDA 1    -- DM(0) = DM(1)
1000010011110011 LDB 0xF3 
0000000000000000 ADD
1000110000000000 STC 0
1000000000000010 LDA 2    -- DM(1) = DM(2)
1000010011110011 LDB 0xF3 
0000000000000000 ADD
1000110000000001 STC 1
1000000000000000 LDA 0    -- RegA = DM(0)
1000010000000001 LDB 1    -- RegB = DM(1)
1011110000010000 JMP 16   -- continue looping
1010010000000000 HLT      -- end