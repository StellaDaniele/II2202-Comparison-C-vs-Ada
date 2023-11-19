with Ada.Text_IO;
with Ada.Threading;

procedure Main is
   task type Thread_Type is
      entry Start (Thread_Arg : Integer);
   end Thread_Type;

   task body Thread_Type is
      Thread_ID : Integer;
   begin
      Thread_ID := Thread_Arg;
      Ada.Text_IO.Put_Line("Hello from thread " & Integer'Image(Thread_ID));
   end;

   Thread : Thread_Type;

begin
   -- Start the thread
   Thread.Start(1);

   -- Do some work in the main thread

   Ada.Text_IO.Put_Line("Main thread exiting");
end Main;
