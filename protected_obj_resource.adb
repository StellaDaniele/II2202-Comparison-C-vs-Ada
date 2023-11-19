with Ada.Text_IO; use Ada.Text_IO;

procedure Resource_Contention_Example is
   protected Shared_Object is
      entry Increment;
   private
      Variable : Integer := 0;
   end Shared_Object;

   task Task_A;
   task Task_B;

   protected body Shared_Object is
      entry Increment when others => null;
   end Shared_Object;

   task body Task_A is
   begin
      loop
         delay 1.0; -- Simulate some work
         Shared_Object.Increment;
      end loop;
   end Task_A;

   task body Task_B is
   begin
      loop
         delay 1.0; -- Simulate some work
         Shared_Object.Increment;
      end loop;
   end Task_B;

begin
   null;
end Resource_Contention_Example;
