    create or replace function totalProducts(sId in varchar) --Function which returns total number of products which a particular seller sells
    return number
    is
    total number(2):=0;
    begin
    select count(*) into total
    from product
    where seller_id=sId;
    return total;
    end;
    /

    declare
    c number(2);
    begin
    c:=totalProducts('sid102');
    dbms_output.put_line('Total products is : '|| c);
    end;