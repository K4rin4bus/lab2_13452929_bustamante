
%========================================================
%                   Pruebas Completas
%========================================================
system("NewSystem", S),
systemAddDrive(S, "C:",  "OS", 10000000000, S1),
systemAddDrive(S1, "D:",  "IOS", 20000000000, S2),
systemRegister(S2, "user1", S3),
systemRegister(S3, "user2", S4),
systemLogin(S4, "user2", S5),
systemLogout(S5, S6),
systemLogin(S6, "user1", S7),
systemSwitchDrive(S7, "C:", S8),
systemMkdir(S8, "c1", S9),
file("food,txt", "hello world", F),
systemAddFile(S9,F, S10).



%========================================================
%                   Pruebas Parciales
%========================================================

system("NewSystem", S),
systemAddDrive(S, "C:", "OS", 10000000000, S1),
systemAddDrive(S1, "D:",  "IOS", 20000000000, S2),
systemRegister(S2, "user1", S3),
systemLogin(S3, "user1", S4),
systemSwitchDrive(S4, "C:", S5),
systemMkdir(S5, "c1", S6),
systemMkdir(S6, "folder", S7),
file("food,txt", "hello world", F),
systemAddFile(S7,F, S8).












