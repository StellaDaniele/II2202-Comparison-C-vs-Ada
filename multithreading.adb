with Ada.Text_IO;

procedure Main is
   task type Thread_Type is
      entry Start (Thread_Arg : Integer);
   end Thread_Type;


   task body Thread_Type is
      Thread_ID : Integer;
   begin
      -- before modify
      -- line 14 & line17 doesn't exist. 
      accept Start (Thread_Arg : Integer) do
      Thread_ID := Thread_Arg;
      Ada.Text_IO.Put_Line("Hello from thread " & Integer'Image(Thread_ID));
      end Start;
   end Thread_Type;

   Thread : Thread_Type;

begin
   -- Start the thread
   Thread.Start(1);

   -- Do some work in the main thread

   Ada.Text_IO.Put_Line("Main thread exiting");
end Main;
