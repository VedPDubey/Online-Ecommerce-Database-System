    --Trigger that will execute before inserting new customer to database and inserting a new cartId to the cart_items table
    
    create or replace function numCartId(cd in varchar) --Function to count number of cart items
    return number
    is
    total number(2):=0;
    begin
    select count(*) into total
    from cart_item
    where cart_id=cd;
    return total;
    end;
    Trigger
    Create or replace trigger before_customer
    before insert
    on
    customer
    for each row
    declare
    c varchar(10);
    n number(2);
    begin
    c:= :new.cart_id;
    n:=numCartId(c);
    if n>0 then
    dbms_output.put_line('Sorry');
    end if;
    insert into cart values(c);
    end;

    create or replace function total_cost(cId in varchar) --Trigger to update the total amount of user everytime he adds something to payment table
    return number
    is
    total number(2) :=0;
    begin
    select sum(cost) into total from product,cart_item where product.product_id=cart_item.product_id and cart_id=cId;
    return total;
    end;

    create or replace trigger before_pay_up
    before insert
    on
    payment
    for each row
    declare
    total number(3);
    begin
    total :=total_cost(:new.cart_id);
    insert into payment values(:new.payment_id,:new.payment_date,:new.payment_type,:new.customer_id,:new.cart_id,total);
    end;