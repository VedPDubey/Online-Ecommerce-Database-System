    create or replace procedure cost_filter(c in number,t in varchar) --Procedure which returns the type of product with the cost less than the given cost
    is
    cs product.cost%type;
    ty product.type%type;
    id product.product_id%type;
    cursor cf is
    select product_id,cost,type from product where cost<c and type=t;
    begin
    open cf;
    loop
    fetch cf into id,cs,ty;
    exit when cf%notfound;
    dbms_output.put_line('Product' || id || 'has cost ' || cs || ' and the type is' || ty);
    end loop;
    close cf;
    exception
    when no_data_found then
    dbms_output.put_line('Sorry no such products exist');
    end; 