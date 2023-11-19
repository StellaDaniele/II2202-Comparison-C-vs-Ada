with Ada.Text_IO; use Ada.Text_IO;
with Ada.Task_Identification; use Ada.Task_Identification;
with Ada.Real_Time; use Ada.Real_Time;

procedure Ada_Race_Condition_Example is
   protected Shared_Object is
      entry Increment;
      function Get_Value return Integer;
   private
      Variable : Integer := 0;
   end Shared_Object;

   task Sender is
   end Sender;

   task Receiver is
   end Receiver;

   protected body Shared_Object is
      entry Increment when others => null;
      procedure Increment is
      begin
         Variable := Variable + 1;
         Put_Line("Incremented Shared_Object to " & Integer'Image(Variable));
      end Increment;

      function Get_Value return Integer is
      begin
         return Variable;
      end Get_Value;
   end Shared_Object;

   task body Sender is
   begin
      loop
         delay 1.0; -- Simulate some work
         Shared_Object.Increment;
      end loop;
   end Sender;

   task body Receiver is
      Local_Copy : Integer;
   begin
      loop
         delay 2.0; -- Simulate some work

         -- Access the protected object
         Local_Copy := Shared_Object.Get_Value;
         Put_Line("Receiver: Read Shared_Object as " & Integer'Image(Local_Copy));
      end loop;
   end Receiver;

begin
   null;
end Ada_Race_Condition_Example;
