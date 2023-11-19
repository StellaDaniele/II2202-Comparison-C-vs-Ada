with Ada.Text_IO; use Ada.Text_IO;

procedure Resource_Contention_Example is
   task type Sender;
   task type Receiver;

   protected Shared_Resource is
      entry Send(Item : Integer);
      entry Receive(Item : out Integer);
   private
      Data : Integer := 0;
   end Shared_Resource;

   task body Sender is
   begin
      loop
         delay 1.0; -- Simulate some work
         Shared_Resource.Send(Data);
      end loop;
   end Sender;

   task body Receiver is
      Local_Item : Integer;
   begin
      loop
         delay 2.0; -- Simulate some work
         Shared_Resource.Receive(Local_Item);
         Put_Line("Receiver: Received item " & Integer'Image(Local_Item));
      end loop;
   end Receiver;

   protected body Shared_Resource is
      entry Send(Item : Integer) when others => null;
      entry Receive(Item : out Integer) when others => null;
   begin
      entry Send(Item : Integer) is
      begin
         Data := Item;
      end Send;

      entry Receive(Item : out Integer) is
      begin
         Item := Data;
      end Receive;
   end Shared_Resource;

begin
   null;
end Resource_Contention_Example;
