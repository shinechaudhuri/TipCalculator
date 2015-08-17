//
//  TipViewController.m
//  Tipster
//
//  Created by Shine Chaudhuri on 2015-08-14.
//  Copyright (c) 2015 Shine Chaudhuri. All rights reserved.
//

#import "TipViewController.h"

@interface TipViewController ()

@property (weak, nonatomic) IBOutlet UITextField *billAmountTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipAmountTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalAmountTextLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipPercentageSegmentControl;

@property (strong, nonatomic) NSArray *tipPercentageArray;

@end

@implementation TipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //Create an Array
    self.tipPercentageArray = @[@0.05, @0.10, @0.15, @0.20, @0.25];
    
    //Remove tip percentage segments created in interfacebuilder
    while(self.tipPercentageSegmentControl.numberOfSegments > 0){
        [self.tipPercentageSegmentControl removeSegmentAtIndex:0 animated:NO];
    }
    
    //use Array of percentage numbers to populate the segment selector
    for(int i = 0; i < self.tipPercentageArray.count; i++) {
        NSNumber *numberInArray = self.tipPercentageArray[i];
        NSString *numberString = [NSString stringWithFormat:@"%.0f%%", numberInArray. doubleValue * 100];
        [self.tipPercentageSegmentControl insertSegmentWithTitle:numberString atIndex:i animated:NO];
    }
    
    //select one of the segments of the segment controller
    [self.tipPercentageSegmentControl setSelectedSegmentIndex:0];
    
    //change the bill amount text label so it is blank
    self.billAmountTextField.text = @"";
    
    [self.tipPercentageSegmentControl addTarget:self action:@selector(calculateTipAndUpdateLabels) forControlEvents: UIControlEventValueChanged];

    self.billAmountTextField.delegate = self;
}

- (BOOL)textField: (UITextField *)textField shouldChangeCharactersInRange:(NSRange)rage replacementString: (NSString *) string {
    
    if (textField == self.billAmountTextField) {
        [self calculateTipAndUpdateLabels];
    }
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)calculateTipAndUpdateLabels {
    //Get the NSNumber out of the array
    NSNumber *tipPercentageNumber = self.tipPercentageArray [[self.tipPercentageSegmentControl selectedSegmentIndex ]];
    
    //Configure variables to do the math
    double billAmount = self.billAmountTextField.text.doubleValue;
    double tipPercentage = tipPercentageNumber.doubleValue;
    
    //do the Math
    double tipAmount = billAmount * tipPercentage;
    double totalAmount = tipAmount + billAmount;
    
    //update the Labels in the view
    self.tipAmountTextLabel.text = [NSString stringWithFormat:@"$%.2f", tipAmount];
    self.totalAmountTextLabel.text = [NSString stringWithFormat:@"$%.2f", totalAmount];

//      Trying to get it so when click on Segmented Control's tip % it automatically changes Amount to pay
//    [self.tipPercentageSegmentControl addTarget:self action:@selector(valueChanged:) forControlEvents: UIControlEventValueChanged];
    
    
}

- (IBAction)didTapCalculateButton:(UIButton *)sender {
    NSLog(@"did tap calculate button");
    [self calculateTipAndUpdateLabels];
    
}
    //Tap to remove keyboard 
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];

    //Calculate on tap
    [self calculateTipAndUpdateLabels];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
