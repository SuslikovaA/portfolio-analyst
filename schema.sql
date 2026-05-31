-- Создание таблиц

CREATE TABLE Должности (
    КодДолжСотр INT PRIMARY KEY,
    ДолжностьСотр VARCHAR(100) NOT NULL
);

CREATE TABLE Категории_Товаров (
    Код_категории INT PRIMARY KEY,
    НазваниеКатегории VARCHAR(100) NOT NULL,
    ОписКатегории VARCHAR(255)
);

CREATE TABLE Тарифные_Планы (
    Код_ТарифПлана INT PRIMARY KEY,
    НазваниеТарифа VARCHAR(100) NOT NULL,
    ЕжемесПлатежТарифа INT NOT NULL,
    ВклМинТарифа INT,
    ВклГБТарифа INT,
    ОписТарифа VARCHAR(255)
);

CREATE TABLE Способы_Оплаты (
    КодСпособОплаты INT PRIMARY KEY,
    СпособОплаты VARCHAR(100) NOT NULL
);

CREATE TABLE Сотрудники (
    Код_сотрудника INT PRIMARY KEY,
    ФамилияСотр VARCHAR(100) NOT NULL,
    ИмяСотр VARCHAR(100) NOT NULL,
    ОтчествоСотр VARCHAR(100),
    ТелефонСотр VARCHAR(100),
    EmailСотр VARCHAR(100),
    КодДолжСотр INT NOT NULL,
    FOREIGN KEY (КодДолжСотр) REFERENCES Должности(КодДолжСотр)
);

CREATE TABLE Товары (
    Код_товара INT PRIMARY KEY,
    НазваниеТовара VARCHAR(100) NOT NULL,
    ПроизводТовара VARCHAR(100),
    СебестоимТовара INT NOT NULL,
    РозничЦенаТовара INT NOT NULL,
    ГарантияТовара INT,
    Код_категории INT NOT NULL,
    FOREIGN KEY (Код_категории) REFERENCES Категории_Товаров(Код_категории)
);

CREATE TABLE Клиенты (
    Код_клиента INT PRIMARY KEY,
    ФамилияКлиента VARCHAR(100) NOT NULL,
    ИмяКлиента VARCHAR(100) NOT NULL,
    ОтчествоКлиента VARCHAR(100),
    ТелефонКлиента VARCHAR(100),
    EmailКлиента VARCHAR(100),
    ДатаРожКлиента DATE,
    ПаспортДанКлиента VARCHAR(100),
    Код_ТарифПлана INT,
    FOREIGN KEY (Код_ТарифПлана) REFERENCES Тарифные_Планы(Код_ТарифПлана)
);

CREATE TABLE Остатки_Товаров (
    Код_ОстаткаТовара INT PRIMARY KEY,
    КолвоТовара INT NOT NULL,
    ПорогПополТов INT NOT NULL,
    Код_товара INT NOT NULL UNIQUE,
    FOREIGN KEY (Код_товара) REFERENCES Товары(Код_товара)
);

CREATE TABLE Продажи (
    Код_продажи INT PRIMARY KEY,
    ДатаПродажи DATE NOT NULL,
    НомерЧека INT NOT NULL UNIQUE,
    Код_клиента INT NOT NULL,
    Код_сотрудника INT NOT NULL,
    КодСпособОплаты INT NOT NULL,
    FOREIGN KEY (Код_клиента) REFERENCES Клиенты(Код_клиента),
    FOREIGN KEY (Код_сотрудника) REFERENCES Сотрудники(Код_сотрудника),
    FOREIGN KEY (КодСпособОплаты) REFERENCES Способы_Оплаты(КодСпособОплаты)
);

CREATE TABLE Устройства (
    Код_устройства INT PRIMARY KEY,
    ДатаАктивУст DATE NOT NULL,
    ГарантияУст INT NOT NULL,
    Код_клиента INT NOT NULL,
    Код_продажи INT NOT NULL UNIQUE,
    FOREIGN KEY (Код_клиента) REFERENCES Клиенты(Код_клиента),
    FOREIGN KEY (Код_продажи) REFERENCES Продажи(Код_продажи)
);

CREATE TABLE Платежи (
    Код_платежа INT PRIMARY KEY,
    ДатаПлатежа DATE NOT NULL,
    СуммаПлатежа INT NOT NULL,
    Код_клиента INT NOT NULL,
    Код_сотрудника INT NOT NULL,
    КодСпособОплаты INT NOT NULL,
    FOREIGN KEY (Код_клиента) REFERENCES Клиенты(Код_клиента),
    FOREIGN KEY (Код_сотрудника) REFERENCES Сотрудники(Код_сотрудника),
    FOREIGN KEY (КодСпособОплаты) REFERENCES Способы_Оплаты(КодСпособОплаты)
);

CREATE TABLE Позиции_Продажи (
    Код_ПозицииТовара INT PRIMARY KEY,
    КолвоПозТовара INT NOT NULL,
    ЦенаЕдПозТовара INT NOT NULL,
    СкидкаПозТовара INT DEFAULT 0,
    Код_продажи INT NOT NULL,
    Код_товара INT NOT NULL,
    FOREIGN KEY (Код_продажи) REFERENCES Продажи(Код_продажи),
    FOREIGN KEY (Код_товара) REFERENCES Товары(Код_товара)
);

CREATE TABLE Ремонты (
    Код_ремонта INT PRIMARY KEY,
    ДатаНачРемонта DATE NOT NULL,
    ДатаКонРемонта DATE,
    СтатусРемонта VARCHAR(100) NOT NULL,
    ОписПроблемы VARCHAR(100) NOT NULL,
    СтоимРемонта INT,
    Код_устройства INT NOT NULL,
    Код_сотрудника INT NOT NULL,
    FOREIGN KEY (Код_устройства) REFERENCES Устройства(Код_устройства),
    FOREIGN KEY (Код_сотрудника) REFERENCES Сотрудники(Код_сотрудника)
);
