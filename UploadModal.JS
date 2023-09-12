import { LightningElement, api, track } from 'lwc';
import { CloseActionScreenEvent } from 'lightning/actions';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import updateContentDocumentTitle from '@salesforce/apex/FileUploadController.updateContentDocumentTitle';

export default class UploadLogoModal extends LightningElement {
    @api recordId;

    @track isModalOpen = false;
    acceptedFormats = ['.jpg', '.jpeg', '.png'];

    openModal() {
        this.isModalOpen = true;
    }

    closeModal() {
        this.isModalOpen = false;
    }

    closeQuickAction() {
        this.dispatchEvent(new CloseActionScreenEvent());
    }
    showToast(title, message, variant) {
        const evt = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant
        });
        this.dispatchEvent(evt);
    }

    handleUploadFinished(event) {
        const uploadedFiles = event.detail.files;
        if (uploadedFiles.length > 0) {
            const contentDocumentId = uploadedFiles[0].documentId;
            //alert('Here is the record ID: ' + this.recordId);

            updateContentDocumentTitle({ contentDocumentId, newTitle: 'LOGO', accountId: this.recordId })
                .then(() => {
                    this.closeModal();
                    this.closeQuickAction();
                    this.showToast('Success', 'Logo uploaded successfully', 'success');
                })
                .catch(error => {
                    // Handle error appropriately.
                    console.error(error);
                });
            // You might want to perform additional actions here, like refreshing the record page.
        }
    }
}
