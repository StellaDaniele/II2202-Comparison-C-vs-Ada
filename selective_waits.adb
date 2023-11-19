with Ada.Text_IO; use Ada.Text_IO;

procedure Resource_Contention_Example is
   task type Producer;
   task type Consumer;

   protected Shared_Resource is
      entry Put(Item : Integer);
      entry Get(Item : out Integer);
   private
      Data : Integer := 0;
   end Shared_Resource;

   task body Producer is
   begin
      loop
         delay 1.0; -- Simulate some work
         Shared_Resource.Put(Data);
      end loop;
   end Producer;

   task body Consumer is
      Local_Item : Integer;
   begin
      loop
         delay 2.0; -- Simulate some work
         select
            when Shared_Resource'Count > 0 =>
               Shared_Resource.Get(Local_Item);
               Put_Line("Consumer: Got item " & Integer'Image(Local_Item));
         or
            delay 0.1; -- Wait for a short time to avoid busy waiting
         end select;
      end loop;
   end Consumer;

   protected body Shared_Resource is
      entry Put(Item : Integer) when others => null;
      entry Get(Item : out Integer) when others => null;
   begin
      entry Put(Item : Integer) is
      begin
         Data := Item;
      end Put;

      entry Get(Item : out Integer) is
      begin
         Item := Data;
      end Get;
   end Shared_Resource;

begin
   null;
end Resource_Contention_Example;
