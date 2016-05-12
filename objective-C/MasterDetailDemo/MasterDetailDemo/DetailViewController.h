//
//  DetailViewController.h
//  MasterDetailDemo
//
//  Created by Yan, Tristan on 3/27/16.
//  Copyright © 2016 Yan, Tristan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

