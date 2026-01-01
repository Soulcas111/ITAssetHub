# 🛠️ IT Asset & Service Desk Hub (企业资产与工单系统)

这是一个模拟企业内部 IT 服务的 Salesforce 实战项目。
主要场景是：员工可以在主页查看自己名下的电脑/设备，如果设备坏了，可以一键提交报修单（Service Ticket）。

项目虽然不大，但完整覆盖了 **LWC 前端交互**、**Apex 后端逻辑** 以及 **Trigger 数据防护** 的全链路开发流程。

![Project Status](https://img.shields.io/badge/Status-Active-success)
![Salesforce](https://img.shields.io/badge/Salesforce-LWC-blue)

## 📸 项目截图

_(这里可以放你的 LWC 界面截图，或者是那个红色的报错框截图，证明功能是活的)_

## ✨ 核心功能与技术亮点

### 1. 员工自助门户 (LWC + Datatable)

- **功能**：使用 `lightning-datatable` 展示当前登录用户 (`UserInfo.getUserId()`) 名下的所有资产。
- **技术点**：
  - 使用了 **`@wire`** 适配器连接 Apex 方法，实现数据的自动获取与缓存。
  - 前端表格支持自定义 **Row Action**（行级按钮）。

### 2. 智能报修单 (LWC Navigation & Pre-fill)

- **功能**：点击资产旁边的“Report Issue”按钮，自动跳转到新建工单页面，并**自动填好**关联资产 ID、标题和优先级。
- **技术点**：
  - 使用了 **`NavigationMixin`** 处理页面跳转。
  - 利用 **`pageReferenceUtils`** 和 `encodeDefaultFieldValues` 实现了跨页面的参数传递（这是很多新手容易卡壳的地方）。

### 3. 业务逻辑防护 (Apex Trigger)

- **功能**：系统强制校验——如果一台设备的状态是“已报废 (Retired)”，则禁止提交任何工单。
- **技术点**：
  - 编写了 `before insert` Trigger。
  - **Bulkification (批量化处理)**：严格遵循最佳实践，将 SOQL 查询移出 For 循环，使用 `Set<Id>` 和 `Map<Id, SObject>` 处理批量数据，防止触发 Governor Limits。

## 📂 项目结构说明

```text
force-app/main/default/
├── classes/
│   └── ITAssetController.cls       # 后端控制器：负责按用户权限抓取资产数据
├── lwc/
│   └── myAssetList/                # 前端组件：处理界面展示和跳转逻辑
├── objects/
│   ├── IT_Asset__c/                # 自定义对象：IT 资产
│   └── Service_Ticket__c/          # 自定义对象：服务工单
└── triggers/
    └── ServiceTicketTrigger.trigger # 触发器：负责拦截非法工单
```
