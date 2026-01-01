import { LightningElement, wire } from "lwc";
import { NavigationMixin } from "lightning/navigation";
import getMyAssets from "@salesforce/apex/ITAssetController.getMyAssets";
import { encodeDefaultFieldValues } from "lightning/pageReferenceUtils";

const COLUMNS = [
  { label: "Asset Name", fieldName: "Name" },
  { label: "Serial Number", fieldName: "Serial_Number__c" },
  { label: "Status", fieldName: "Status__c" },
  { label: "Purchase Date", fieldName: "Purchase_Date__c", type: "date" },
  {
    type: "button",
    typeAttributes: {
      label: "Report Issue",
      name: "report_issue",
      title: "Click to report an issue",
      variant: "brand-outline"
    }
  }
];

export default class MyAssetList extends NavigationMixin(LightningElement) {
  columns = COLUMNS;

  @wire(getMyAssets)
  assets;

  handleRowAction(event) {
    const actionName = event.detail.action.name;
    const row = event.detail.row;

    if (actionName === "report_issue") {
      this.createNewTicket(row);
    }
  }

  createNewTicket(row) {
    // 定义要预填的字段值
    const defaultValues = encodeDefaultFieldValues({
      Related_Asset__c: row.Id,
      Subject__c: "Issue with " + row.Name,
      Priority__c: "Medium"
    });

    this[NavigationMixin.Navigate]({
      type: "standard__objectPage",
      attributes: {
        objectApiName: "Service_Ticket__c",
        actionName: "new"
      },
      state: {
        defaultFieldValues: defaultValues
      }
    });
  }
}
