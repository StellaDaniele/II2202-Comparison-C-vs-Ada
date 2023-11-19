with Ada.Text_IO; use Ada.Text_IO;
with Ada.Task_Identification; use Ada.Task_Identification;
with Ada.Real_Time; use Ada.Real_Time;

procedure Rendezvous_Example is
   task Sender is
      entry Send (Value : Integer);
   end Sender;

   task Receiver is
      entry Receive (Value : out Integer);
   end Receiver;

   task body Sender is
      Data : Integer := 42;
   begin
      loop
         delay 1.0; -- Simulate some work
         accept Send (Value : in Integer) do
            Data := Value;
            Put_Line("Sender: Received value " & Integer'Image(Data));
         end Send;
      end loop;
   end Sender;

   task body Receiver is
      Received_Data : Integer;
   begin
      loop
         delay 2.0; -- Simulate some work
         accept Receive (Value : out Integer) do
            Value := Received_Data;
            Put_Line("Receiver: Sent value " & Integer'Image(Received_Data));
         end Receive;
      end loop;
   end Receiver;

begin
   null;
end Rendezvous_Example;
