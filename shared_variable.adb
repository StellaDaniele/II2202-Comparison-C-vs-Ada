with Ada.Text_IO; use Ada.Text_IO;
with Ada.Task_Identification; use Ada.Task_Identification;
with Ada.Real_Time; use Ada.Real_Time;

procedure Shared_Variable_Example is
   -- Shared variable declaration
   Shared_Variable : Integer := 0;

   task Sender is
      entry Send (Value : Integer);
   end Sender;

   task Receiver is
   end Receiver;

   task body Sender is
   begin
      loop
         delay 1.0; -- Simulate some work
         Shared_Variable := Shared_Variable + 1;
         Put_Line("Sender: Incremented Shared_Variable to " & Integer'Image(Shared_Variable));
      end loop;
   end Sender;

   task body Receiver is
      Local_Copy : Integer;
   begin
      loop
         delay 2.0; -- Simulate some work

         -- Access the shared variable
         Local_Copy := Shared_Variable;
         Put_Line("Receiver: Read Shared_Variable as " & Integer'Image(Local_Copy));
      end loop;
   end Receiver;

begin
   null;
end Shared_Variable_Example;
