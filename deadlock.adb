with Ada.Text_IO; use Ada.Text_IO;
with Ada.Task_Identification; use Ada.Task_Identification;

procedure Ada_Deadlock_Example is
   task Task_A;
   task Task_B;

   protected Shared_Object is
      entry Increment;
   private
      Variable : Integer := 0;
   end Shared_Object;

   task body Task_A is
   begin
      loop
         delay 1.0; -- Simulate some work

         -- Task_A attempts to increment the shared variable
         Shared_Object.Increment;

         -- Simulate some additional work
         delay 0.5;
      end loop;
   end Task_A;

   task body Task_B is
   begin
      loop
         delay 1.0; -- Simulate some work

         -- Task_B attempts to increment the shared variable
         Shared_Object.Increment;

         -- Simulate some additional work
         delay 0.5;
      end loop;
   end Task_B;

   protected body Shared_Object is
      entry Increment when others => null;
      procedure Increment is
      begin
         -- Simulate some work
         delay 0.2;

         -- Perform the actual increment
         Variable := Variable + 1;

         Put_Line("Shared_Object: Incremented to " & Integer'Image(Variable));
      end Increment;
   end Shared_Object;

begin
   null;
end Ada_Deadlock_Example;
