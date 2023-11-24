with Ada.Text_IO; use Ada.Text_IO;
with Ada.Task_Identification; use Ada.Task_Identification;
with Ada.Real_Time; use Ada.Real_Time;

procedure Deadlock_Example is
   protected Resource is
      entry Acquire;
      entry Release;
   private
      Taken : Boolean := False;
   end Resource;

   task Task_A;
   task Task_B;

   protected body Resource is
      entry Acquire when not Taken is
      begin
         Taken := True;
      end Acquire;

      entry Release when Taken is
      begin
         Taken := False;
      end Release;
   end Resource;

   task body Task_A is
   begin
      Put_Line("Task_A started");
      delay 0.1; -- Simulate some work

      -- Task_A tries to acquire the resource held by Task_B
      Put_Line("Task_A waiting for Task_B to release the resource");
      Resource.Acquire;

      Put_Line("Task_A continues after getting the resource");

      -- Simulate more work
      delay 0.1;

      -- Task_A releases the resource
      Resource.Release;
   end Task_A;

   task body Task_B is
   begin
      Put_Line("Task_B started");
      delay 0.1; -- Simulate some work

      -- Task_B tries to acquire the resource held by Task_A
      Put_Line("Task_B waiting for Task_A to release the resource");
      Resource.Acquire;

      Put_Line("Task_B continues after getting the resource");

      -- Simulate more work
      delay 0.1;

      -- Task_B releases the resource
      Resource.Release;
   end Task_B;

begin
   -- Start both tasks simultaneously
   null;

   -- Wait for a while to allow tasks to execute
   delay 0.2;

   -- Tasks are now deadlocked
   Put_Line("Deadlock reached");
end Deadlock_Example;
