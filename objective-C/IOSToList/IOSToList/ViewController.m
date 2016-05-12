//
//  ViewController.m
//  IOSToList
//
//  Created by Yan, Tristan on 3/28/16.
//  Copyright © 2016 Yan, Tristan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UITextField *txtName;
@property (strong, nonatomic) IBOutlet UILabel *helloLabel;
@end

@implementation ViewController

@synthesize txtName;
@synthesize helloLabel;

- (IBAction)sayHello:(id)sender {
//    NSString *helloword = [@"Hello " stringByAppendingString: _txtName.text];
    NSString *helloword = [NSString stringWithFormat:@"Hello %@!!!", txtName.text];
    helloLabel.text = helloword;
//    [self.helloLabel setText:helloword];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
