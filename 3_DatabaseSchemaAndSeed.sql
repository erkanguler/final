
USE ECommerce; 

CREATE TABLE [dbo].[Customer] (
    [id]         INT            IDENTITY (1, 1) NOT NULL,
    [first_name] NVARCHAR (80)  NOT NULL,
    [last_name]  NVARCHAR (80)  NOT NULL,
    [email]      NVARCHAR (150) NOT NULL,
    [password]   NVARCHAR (100) NOT NULL,
    CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED ([id] ASC)
);

CREATE TABLE [dbo].[CustomerNoLogin] (
    [id]         INT            IDENTITY (1, 1) NOT NULL,
    [first_name] NVARCHAR (80)  NOT NULL,
    [last_name]  NVARCHAR (80)  NOT NULL,
    [email]      NVARCHAR (150) NOT NULL,
    [street]     NVARCHAR (160) NOT NULL,
    [zipcode]    NVARCHAR (50)  NOT NULL,
    [city]       NVARCHAR (80)  NOT NULL,
    CONSTRAINT [PK_CustomerNoLogin] PRIMARY KEY CLUSTERED ([id] ASC)
);

CREATE TABLE [dbo].[Category] (
    [id]     INT            IDENTITY (1, 1) NOT NULL,
    [name]   NVARCHAR (80)  NOT NULL,
    [parent] INT            NULL,
    [path]   NVARCHAR (200) NULL,
    CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_Category_Category] FOREIGN KEY ([parent]) REFERENCES [dbo].[Category] ([id])
);


CREATE UNIQUE NONCLUSTERED INDEX [Index_Category_1]
    ON [dbo].[Category]([path] ASC);


CREATE TABLE [dbo].[Product] (
    [id]          INT            IDENTITY (1, 1) NOT NULL,
    [title]       NVARCHAR (160) NULL,
    [price]       DECIMAL (18,2)   NULL,
    [image]       NVARCHAR (240) NULL,
    [category_id] INT            NOT NULL,
    CONSTRAINT [PK_product] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_product_Category] FOREIGN KEY ([category_id]) REFERENCES [dbo].[Category] ([id])
);


CREATE TABLE [dbo].[Order] (
    [id]          INT      IDENTITY (1, 1) NOT NULL,
    [customer_id] INT      NOT NULL,
    [date]        DATETIME CONSTRAINT [DEFAULT_Order_date] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_Order_Customer] FOREIGN KEY ([customer_id]) REFERENCES [dbo].[Customer] ([id])
);

CREATE TABLE [dbo].[OrderNoLogin] (
    [id]          INT      IDENTITY (1, 1) NOT NULL,
    [customer_id] INT      NOT NULL,
    [date]        DATETIME CONSTRAINT [DEFAULT_OrderNoLogin_date] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_OrderNoLogin] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_OrderNoLogin_CustomerNoLogin] FOREIGN KEY ([customer_id]) REFERENCES [dbo].[CustomerNoLogin] ([id])
);


CREATE TABLE [dbo].[Order_Product] (
    [order_id]   INT             NOT NULL,
    [product_id] INT             NOT NULL,
    [quantity]   INT             NOT NULL,
    [price]      DECIMAL (18, 2) NOT NULL,
    CONSTRAINT [PK_Order_Product] PRIMARY KEY CLUSTERED ([order_id] ASC, [product_id] ASC),
    CONSTRAINT [FK_Order_Product_Order] FOREIGN KEY ([order_id]) REFERENCES [dbo].[Order] ([id]),
    CONSTRAINT [FK_Order_Product_Product] FOREIGN KEY ([product_id]) REFERENCES [dbo].[Product] ([id])
);

CREATE TABLE [dbo].[OrderNoLogin_Product] (
    [order_id]   INT             NOT NULL,
    [product_id] INT             NOT NULL,
    [quantity]   INT             NOT NULL,
    [price]      DECIMAL (18, 2) NOT NULL,
    CONSTRAINT [PK_OrderNoLogin_Product] PRIMARY KEY CLUSTERED ([order_id] ASC, [product_id] ASC),
    CONSTRAINT [FK_OrderNoLogin_Product_OrderNoLogin] FOREIGN KEY ([order_id]) REFERENCES [dbo].[OrderNoLogin] ([id]),
    CONSTRAINT [FK_OrderNoLogin_Product] FOREIGN KEY ([product_id]) REFERENCES [dbo].[Product] ([id])
);



/* ----------  CATEGORY  ---------- */
INSERT INTO Category (name, parent, path)
VALUES (N'root', NULL, N'');

/* Category women */
INSERT INTO Category (name, parent, path)
VALUES (N'Women', 1, N'/women');

    INSERT INTO Category (name, parent, path)
    VALUES (N'Clothing', 2, N'/women/clothing');

        INSERT INTO Category (name, parent, path)
        VALUES (N'Dresses', 3, N'/women/clothing/dresses');
        
        INSERT INTO Category (name, parent, path)
        VALUES (N'Jeans', 3, N'/women/clothing/jeans');
        
        INSERT INTO Category (name, parent, path)
        VALUES (N'Blazers', 3, N'/women/clothing/blazers');

    INSERT INTO Category (name, parent, path)
    VALUES (N'Shoes', 2, N'/women/shoes');

        INSERT INTO Category (name, parent, path)
        VALUES (N'Boots', 7, N'/women/shoes/boots');

        INSERT INTO Category (name, parent, path)
        VALUES (N'Sneakers', 7, N'/women/shoes/sneakers');

        INSERT INTO Category (name, parent, path)
        VALUES (N'Sandals', 7, N'/women/shoes/sandals');

    INSERT INTO Category (name, parent, path)
    VALUES (N'Bags', 2, N'/women/bags');

/* Category men */
INSERT INTO Category (name, parent, path)
VALUES (N'Men', 1, N'/men');

    INSERT INTO Category (name, parent, path)
    VALUES (N'Clothing', 12, N'/men/clothing');

        INSERT INTO Category (name, parent, path)
        VALUES (N'Pants', 13, N'/men/clothing/pants');

        INSERT INTO Category (name, parent, path)
        VALUES (N'Jeans', 13, N'/men/clothing/jeans');

    INSERT INTO Category (name, parent, path)
    VALUES (N'Shoes', 12, N'/men/shoes');

        INSERT INTO Category (name, parent, path)
        VALUES (N'Boots', 16, N'/men/shoes/boots');

        INSERT INTO Category (name, parent, path)
        VALUES (N'Sneakers', 16, N'/men/shoes/sneakers');

/* Category kids */
INSERT INTO Category (name, parent, path)
VALUES (N'Kids', 1, N'/kids');

    INSERT INTO Category (name, parent, path)
    VALUES (N'Clothing', 19, N'/kids/clothing');

        INSERT INTO Category (name, parent, path)
        VALUES (N'Fleece', 20, N'/kids/clothing/fleece');

        INSERT INTO Category (name, parent, path)
        VALUES (N'Jeans', 20, N'/kids/clothing/jeans');

    INSERT INTO Category (name, parent, path)
    VALUES (N'Shoes', 19, N'/kids/shoes');

        INSERT INTO Category (name, parent, path)
        VALUES (N'Boots', 23, N'/kids/shoes/boots');

        INSERT INTO Category (name, parent, path)
        VALUES (N'Sneakers', 23, N'/kids/shoes/sneakers');

        INSERT INTO Category (name, parent, path)
        VALUES (N'Slippers', 23, N'/kids/shoes/slippers');

    INSERT INTO Category (name, parent, path)
    VALUES (N'Toys', 19, N'/kids/toys');

/* Category men */
        INSERT INTO Category (name, parent, path)
        VALUES (N'Knitwear', 13, N'/men/clothing/knitwear');


/* ----------  PRODUCTS  ----------  */

/* women dresses */
INSERT INTO Product (title, price, image, category_id) VALUES 
(N'AURIA SATIN MAXI DRESS', 124.95, N'/img/bardot.webp', 4),
(N'VISPARKLING 3/4 O-NECK DRESS', 89.95, N'/img/vila.webp', 4),
(N'KAVERUS UNIKKO', 299.95, N'/img/marimekko.webp', 4);

/* women jeans */
INSERT INTO Product (title, price, image, category_id) VALUES 
(N'Day Birger et Mikkelsen', 139.90, N'/img/jeans.webp', 5),
(N'Chain-Trim High-Rise Flare', 149.95, N'/img/laurenjeans.webp', 5),
(N'High-Rise Flare Sailor Jean', 244.90, N'/img/lauren.webp', 5),
(N'SHELLIE', 209.95, N'/img/munthe.webp', 5);

/* women blazers */
INSERT INTO Product (title, price, image, category_id) VALUES 
(N'CROP WOOL GOLD BUTTON', 259.95, N'/img/hilfiger.webp', 6),
(N'Ella tailored peplum blazer', 304.95, N'/img/malina.webp', 6),
(N'ONLFREJA NANCY SHORT LEO', 99.95, N'/img/only.webp', 6),
(N'GERRI', 409.95, N'/img/tiger.webp', 6);

/* women sneakers */
INSERT INTO Product (title, price, image, category_id) VALUES 
(N'GAZELLE W', 119.95, N'/img/adidas.webp', 9),
(N'New Balance 574', 104.90, N'/img/newbalance.webp', 9),
(N'MENNET STONE', 89.95, N'/img/replay.webp', 9);

/* women boots */
INSERT INTO Product (title, price, image, category_id) VALUES 
(N'Fallwi Chelsea Boot', 139.95, N'/img/gant.webp', 8),
(N'YVETTE', 124.95, N'/img/guess.webp', 8),
(N'FULL LEATHER NAPLACK', 109.95, N'/img/inuikii.webp', 8),
(N'Classic Ultra Mini New Heights', 209.95, N'/img/ugg.webp', 8);

/* women sandals */
INSERT INTO Product (title, price, image, category_id) VALUES 
(N'Lisa Leather', 64.95, N'/img/woden.webp', 10),
(N'Kailyn-R Sandal', 79.90, N'/img/steve.webp', 10),
(N'Sandals - Block heels', 124.95, N'/img/angulus.webp', 10);

/* women bags */
INSERT INTO Product (title, price, image, category_id) VALUES 
(N'TABBY SHOULDER BAG', 444.95, N'/img/coach.webp', 11),
(N'ECO BRENTON TOTE', 189.90, N'/img/guessbag.webp', 11),
(N'BROOKLYN SB', 349.95, N'/img/coachbag.webp', 11),
(N'Mini ID Card Case', 89.90, N'/img/coachc.webp', 11),
(N'ARCADIA SHINY STRUCTURE', 99.95, N'/img/hvisk.webp', 11),
(N'Leather Small Farrah Satchel', 329.95, N'/img/laurenbag.webp', 11);

/* men pants */
INSERT INTO Product (title, price, image, category_id) VALUES 
(N'Flannel wool blend formal', 79.95, N'/img/lindbergh.webp', 14),
(N'Traveler slim chino', 59.95, N'/img/tomtailer.webp', 14),
(N'CORE DENTON 1985 PIMA', 109.90, N'/img/tommy.webp', 14);

/* men knitwear */
INSERT INTO Product (title, price, image, category_id) VALUES 
(N'Fernando Roundneck', 132.95, N'/img/knitwear1.webp', 28),
(N'ORIGINAL HM SWEATER', 74.90, N'/img/knitwear2.webp', 28),
(N'Reine Half zip', 219.95, N'/img/knitwear3.webp', 28),
(N'SLHDANE KNIT STRUCTURE', 62.90, N'/img/knitwear4.webp', 28),
(N'Cable Crew Neck Jumper', 73.95, N'/img/knitwear5.webp', 28);

/* men jeans */
INSERT INTO Product (title, price, image, category_id) VALUES 
(N'Texas slim', 61.90, N'/img/wrangler.webp', 15),
(N'RYAN SLIM STR CH0237', 61.90, N'/img/tommyjeans.webp', 15),
(N'JIGLEN JICON JJ 357', 58.90, N'/img/jackjones.webp', 15);

/* men boots */
INSERT INTO Product (title, price, image, category_id)
VALUES (N'Larchmont MID CHELSEA BOOT', 99.90, N'/img/timberland.webp', 17);

INSERT INTO Product (title, price, image, category_id)
VALUES (N'Alden Brook MID LACE UP', 89.95, N'/img/timberland2.webp', 17);

/* men sneakers */
INSERT INTO Product (title, price, image, category_id)
VALUES (N'Armin Canvas Low-Top', 69.90, N'/img/poloralph.webp', 18);

INSERT INTO Product (title, price, image, category_id)
VALUES (N'ET EVOLUTION CDX', 79.95, N'/img/etonic.webp', 18);

INSERT INTO Product (title, price, image, category_id)
VALUES (N'SUMMITS - HIGH RANGE', 74.90, N'/img/skechers.webp', 18);

/* kids fleece */
INSERT INTO Product (title, price, image, category_id) VALUES 
(N'Uberto', 54.95, N'/img/molo.webp', 21),
(N'Wool Baby Jacket', 41.90, N'/img/mikkline.webp', 21),
(N'Fleece Jacket Recycled', 59.95, N'/img/crosebrown.webp', 21),
(N'LYNX Jacket', 29.90, N'/img/isbjorn.webp', 21);

/* kids jeans */
INSERT INTO Product (title, price, image, category_id) VALUES 
(N'NW BOOTCUT PANT NOOS', 29.95, N'/img/lmtd.webp', 22),
(N'Daren', 23.90, N'/img/lee.webp', 22),
(N'DENIM JEANS RA379 GIRL', 27.95, N'/img/vero.webp', 22),
(N'JJORIGINAL MF 992 SN', 27.90, N'/img/jackjeans.webp', 22),
(N'TNLykke Wide Jeans', 24.95, N'/img/thenew.webp', 22);

/* kids boots */
INSERT INTO Product (title, price, image, category_id) VALUES 
(N'Booties with elastic', 99.95, N'/img/angulusboot.webp', 24),
(N'Pokey Pine Warm Lined', 64.90, N'/img/timberlandkid.webp', 24),
(N'Chelsea Cama', 69.95, N'/img/wheat.webp', 24),
(N'Booties flat with elastic', 94.90, N'/img/anguluskid.webp', 24),
(N'Winterboot Stewie Tex', 79.95, N'/img/wheatboot.webp', 24),
(N'bisgaard neo lamb', 109.90, N'/img/bisgaard.webp', 24);

/* kids sneakers */
INSERT INTO Product (title, price, image, category_id) VALUES 
(N'Odda 2V', 47.95, N'/img/viking.webp', 25),
(N'LITE INFANT', 51.90, N'/img/ecco.webp', 25),
(N'Jack Warm GTX', 99.95, N'/img/vikingkid.webp', 25),
(N'ST Runner v3 NL', 46.90, N'/img/puma.webp', 25),
(N'Aery Tau GTX', 68.95, N'/img/vikings.webp', 25);

/* kids slippers */
INSERT INTO Product (title, price, image, category_id) VALUES 
(N'Indoor Shoe Taj', 42.95, N'/img/wslippers.webp', 26),
(N'bisgaard baby wool', 34.90, N'/img/bslippers.webp', 26),
(N'bisgaard baby cotton', 32.95, N'/img/slippersb.webp', 26);

/* kids toys */
INSERT INTO Product (title, price, image, category_id) VALUES 
(N'Play tent stripe grey', 24.95, N'/img/toy1.webp', 27),
(N'KIT BABY GYM WITH TOY', 69.90, N'/img/toy2.webp', 27),
(N'City Red Double-Decker', 23.95, N'/img/toy3.webp', 27),
(N'Pocket Friend - Astronaut', 20.90, N'/img/toy4.webp', 27),
(N'SPIROGRAPH JUNIOR', 29.95, N'/img/toy5.webp', 27),
(N'Spiderman Costume', 38.90, N'/img/toy6.webp', 27);


/* Customer */
INSERT INTO Customer
VALUES (N'Emma', N'Andersson', N'dan@dan.com', N'dan123');

INSERT INTO Customer
VALUES (N'Emil', N'Svensson', N'san@san.com', N'san123');


/* Order */
INSERT INTO [dbo].[Order] ( customer_id )
VALUES (1);

INSERT INTO [dbo].[Order] ( customer_id )
VALUES (2);


/* Order_Product */
INSERT INTO [dbo].[Order_Product] ( order_id, product_id, quantity, price)
VALUES ( 1, 1, 7, 299.95 );

INSERT INTO [dbo].[Order_Product] ( order_id, product_id, quantity, price)
VALUES ( 1, 2, 7, 299.95 );