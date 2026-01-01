Id myId = UserInfo.getUserId();

List<IT_Asset__c> assetsToInsert = new List<IT_Asset__c>();

// 创建第1个资产：正在使用的 MacBook
assetsToInsert.add(new IT_Asset__c(
    Name = 'MacBook Pro M3 (Company)',
    Serial_Number__c = 'MB-2024-001',
    Status__c = 'In Use',
    Purchase_Date__c = Date.today().addMonths(-3),
    OwnerId = myId 
));

// 创建第2个资产：备用的显示器
assetsToInsert.add(new IT_Asset__c(
    Name = 'Dell 27 Monitor',
    Serial_Number__c = 'DELL-XK992',
    Status__c = 'In Stock',
    Purchase_Date__c = Date.today().addYears(-1),
    OwnerId = myId
));

// 创建第3个资产：已报废的老电脑 
assetsToInsert.add(new IT_Asset__c(
    Name = 'Old Windows Laptop',
    Serial_Number__c = 'WIN-2019-old',
    Status__c = 'Retired',
    Purchase_Date__c = Date.newInstance(2019, 5, 20),
    OwnerId = myId
));

insert assetsToInsert;

System.debug('成功创建了 ' + assetsToInsert.size() + ' 条资产数据！');