import { LightningElement, wire } from 'lwc';
// 导入 Apex 方法
import getMyAssets from '@salesforce/apex/ITAssetController.getMyAssets';

// 定义表格的列 
const COLUMNS = [
    { label: 'Asset Name', fieldName: 'Name' },
    { label: 'Serial Number', fieldName: 'Serial_Number__c' },
    { label: 'Status', fieldName: 'Status__c' },
    { label: 'Purchase Date', fieldName: 'Purchase_Date__c', type: 'date' }
];

export default class MyAssetList extends LightningElement {
    columns = COLUMNS;
    
    // 使用 @wire 装饰器自动调用 Apex
    @wire(getMyAssets) 
    assets;
}