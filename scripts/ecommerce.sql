    CREATE TABLE Cart 
    ( 
        Cart_id VARCHAR(7) NOT NULL, 
        PRIMARY KEY(Cart_id) 
    );

    CREATE TABLE Customer 
    ( 
        Customer_id VARCHAR(6) NOT NULL, 
        c_pass VARCHAR(10) NOT NULL, 
        Name VARCHAR(20) NOT NULL, 
        Address VARCHAR(20) NOT NULL, 
        Pincode NUMBER(6) NOT NULL, 
        Phone_number_s number(10) NOT NULL, 
        PRIMARY KEY (Customer_id), 
        Cart_id VARCHAR(7) NOT NULL, 
        FOREIGN KEY(Cart_id) REFERENCES cart(Cart_id) 
    );

    CREATE TABLE Seller 
    ( 
        Seller_id VARCHAR(6) NOT NULL, 
        s_pass VARCHAR(10) NOT NULL, 
        Name VARCHAR(20) NOT NULL, 
        Address VARCHAR(10) NOT NULL, 
        PRIMARY KEY (Seller_id) 
    );

    CREATE TABLE Seller_Phone_num 
    ( 
        Phone_num NUMBER(10) NOT NULL, 
        Seller_id VARCHAR(6) NOT NULL, 
        PRIMARY KEY (Phone_num, Seller_id), 
        FOREIGN KEY (Seller_id) REFERENCES Seller(Seller_id) 
        ON DELETE CASCADE 
    );

    CREATE TABLE Payment 
    ( 
        payment_id VARCHAR(7) NOT NULL, 
        payment_date DATE NOT NULL, 
        Payment_type VARCHAR(10) NOT NULL, 
        Customer_id VARCHAR(6) NOT NULL, 
        Cart_id VARCHAR(7) NOT NULL, 
        PRIMARY KEY (payment_id), 
        FOREIGN KEY (Customer_id) REFERENCES Customer(Customer_id), 
        FOREIGN KEY (Cart_id) REFERENCES Cart(Cart_id), 
        total_amount numeric(6) 
    );

    CREATE TABLE Product 
    ( 
        Product_id VARCHAR(7) NOT NULL, 
        Type VARCHAR(7) NOT NULL, 
        Color VARCHAR(15) NOT NULL, 
        P_Size VARCHAR(2) NOT NULL, 
        Gender CHAR(1) NOT NULL, 
        Commission NUMBER(2) NOT NULL, 
        Cost NUMBER(5) NOT NULL, 
        Quantity NUMBER(2) NOT NULL, 
        Seller_id VARCHAR(6), 
        PRIMARY KEY (Product_id), 
        FOREIGN KEY (Seller_id) REFERENCES Seller(Seller_id) 
        ON DELETE SET NULL 
    );

    CREATE TABLE Cart_item 
    ( 
        Quantity_wished NUMBER(1) NOT NULL, 
        Date_Added DATE NOT NULL, 
        Cart_id VARCHAR(7) NOT NULL, 
        Product_id VARCHAR(7) NOT NULL, 
        FOREIGN KEY (Cart_id) REFERENCES Cart(Cart_id), 
        FOREIGN KEY (Product_id) REFERENCES Product(Product_id), 
        Primary key(Cart_id,Product_id) 
    );

    alter table Cart_item add purchased varchar(3) default 'NO';

    insert into Cart values('crt1011');

    insert into Customer values('cid100','ABCM1235','rajat','G-453','632014',9893135876, 'crt1011');

    insert into Seller values('sid100','12345','aman','delhi cmc');

    insert into Product values('pid1001','jeans','red','32','M',10,10005,20,'sid100');

    insert into Seller_Phone_num values('9943336206','sid100');

    insert into Cart_item values(3,to_date('10-OCT-1999','dd-mon-yyyy'),'crt1011','pid1001','Y');

    insert into Payment values('pmt1001',to_date('10-OCT-1999','dd-mon-yyyy'),'online','cid100','crt1011',NULL);

    insert into Cart values('crt1012');

    insert into Customer values('cid102','ABCM1245','rohit','G-453','632014',9893135876, 'crt1012');

    insert into Seller values('sid101','12045','man','di cmc');

    insert into Product values('pid1002','shirt','blue','22','F',11,10000,10,'sid101');

    insert into Seller_Phone_num values('9943336216','sid101');

    insert into Cart_item values(3,to_date('10-OCT-1999','dd-mon-yyyy'),'crt1012','pid1002','Z');

    insert into Payment values('pmt1003',to_date('10-OCT-1999','dd-mon-yyyy'),'credit','cid102','crt1012',NULL);

    insert into Cart values('crt1013');

    insert into Seller values('sid102','12046','woman','di cmc');

    insert into Seller_Phone_num values('9943336316','sid102');

    insert into Customer values('cid103','ABCM1236','roshni','G-453','100706',9894135876, 'crt1013');

    insert into Payment values('pmt1004',to_date('10-OCT-1999','dd-mon-yyyy'),'gpay','cid103','crt1013',NULL);

SELECT * FROM Customer 
;

    select * from product where product_id in( 
        select product_id from Cart_item where (Cart_id in ( 
            select Cart_id from Customer where Customer_id='cid100' 
        )));

    select product_id,Quantity_wished from Cart_item where (purchased='Y' and Cart_id in (select Cart_id from customer where Customer_id='cid101'));

    select product_id,Quantity_wished from Cart_item where (Cart_id in (select Cart_id from customer where Customer_id='cid101'));

    select product_id,Quantity_wished from Cart_item where (Cart_id in (select Cart_id from customer where Customer_id='cid102'));

    select product_id, color, cost, seller_id from product where (type='jeans' and p_size='32' and gender='M' and quantity>0);

delete from cart_item where (product_id='pid1001' and Cart_id in (select cart_id from Customer where Customer_id='cid100'));

