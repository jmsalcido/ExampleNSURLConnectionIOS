//
//  ViewController.h
//  NSURLConnectionIOS
//
//  Created by Jose Miguel Salcido on 1/20/13.
//  Copyright (c) 2013 Dudes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    NSMutableData *m_data;
    UIAlertView *m_alert;
}
@property (strong, nonatomic) IBOutlet UITextView *texto;

- (IBAction)obtenerTexto:(id)sender;

@end
