//
//  AddPersonDetailsViewController.m
//  PeekABoo
//
//  Created by Apple on 30/01/14.
//  Copyright (c) 2014 Tablified Solutions. All rights reserved.
//

#import "AddPersonDetailsViewController.h"
#import "Person.h"

@interface AddPersonDetailsViewController () <UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate>
{
    __weak IBOutlet UITextField *nameTextField;
    __weak IBOutlet UITextField *addressTextField;
    __weak IBOutlet UITextField *phoneTextField;
    __weak IBOutlet UITextField *emailTextField;
    __weak IBOutlet UIButton *addPhotoButton;
    Person *person;
}

@end

@implementation AddPersonDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    person = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:person.managedObjectContext];
}

- (IBAction)onAddPhotoPressed:(id)sender {

    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Choose from library", nil];
    [actionSheet showInView:self.view];
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self choosePhotoFromLibrary];
    }
}

-(void)choosePhotoFromLibrary
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        controller.allowsEditing = NO;
        controller.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        controller.delegate = self;
        [self.navigationController presentViewController:controller animated:YES completion:nil];
    }
}

- (IBAction)onSaveButtonPressed:(id)sender {
    person.name = nameTextField.text;
    person.address = addressTextField.text;
    person.phone = phoneTextField.text;
    person.email = emailTextField.text;
    
    NSError *error = nil;
    [person.managedObjectContext save:&error];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    NSLog(@"test");
    [addPhotoButton setBackgroundImage:image forState:UIControlStateNormal];
    [addPhotoButton setTitle:@"" forState:UIControlStateNormal];
    
    NSData *imageData = UIImageJPEGRepresentation(image, 0.1);
    
    int totalCount = 0;
    NSArray *bundleArray = [[NSBundle mainBundle] pathsForResourcesOfType:@"jpeg" inDirectory:nil];
    for (NSString *fileName in bundleArray)
    {
        if([[fileName lastPathComponent] hasPrefix:@"image_"]){
            totalCount++;
        }
    }
    
    NSString *imageName = [NSString stringWithFormat:@"image_%i", totalCount];

    NSURL *url = [NSURL URLWithString:[[NSBundle mainBundle] pathForResource:imageName ofType:@"jpeg"]];
    [imageData writeToURL:url atomically:YES];
    person.photourl = [url absoluteString];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag == 1) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return (newLength > 10) ? NO : YES;
    }
    return YES;
}


@end
