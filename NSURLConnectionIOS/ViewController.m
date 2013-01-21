//
//  ViewController.m
//  NSURLConnectionIOS
//
//  Created by Jose Miguel Salcido on 1/20/13.
//  Copyright (c) 2013 Dudes. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

@synthesize texto;

// ----------------------------------------------
// Start here
// ----------------------------------------------
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // It is not possible to edit the text.
	[texto setEditable:NO];
}

// ----------------------------------------------
// IBActions
// ----------------------------------------------
- (IBAction)obtenerTexto:(id)sender
{
    // Create the alert that displays the "loading screen"
    UIAlertView *alert;
    alert = [[UIAlertView alloc] initWithTitle:@"Espera" message:@"Estamos descargando el texto" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    
    // Create an UIActivityIndicatorView as a spinner.
    UIActivityIndicatorView *spinner;
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    // Create the request and the connection.
    NSURL *url = [NSURL URLWithString: @"http://otfusion.org/if.html"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if(connection) {
        // If the connection is succesful, init the data (m_data is at the header)
        m_data = [NSMutableData data];
        
        // Show the UIAlertView
        [alert show];
        
        // Add and start animating the spinner at the center and -50px MAX_height
        spinner.center = CGPointMake(alert.bounds.size.width/2, alert.bounds.size.height - 50);
        [alert addSubview:spinner];
        [spinner startAnimating];
        
        // Make the alert available in the entire control
        m_alert = alert;
    } else {
        
        // Alert that the connection was unsucessful
        alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No nos pudimos conectar" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

// ----------------------------------------------
// NSURLConnection Delegate Methods
// ----------------------------------------------

- (void) connection: (NSURLConnection *) connection
 didReceiveResponse: (NSURLResponse *) response
{
    // If the connection got response, set lenght equal to 0
    [m_data setLength:0];
}

- (void) connection:  (NSURLConnection *) connection  didReceiveData: (NSData *) data
{
    // Append the data when the controller receives data from the connection
    [m_data appendData:data];
}

- (void) connection: (NSURLConnection *) connection  didFailWithError: (NSError *) error
{
    // Alert the user that the connection did fail
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ERROR" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert dismissWithClickedButtonIndex:0 animated:YES];
}

- (void) connectionDidFinishLoading: (NSURLConnection *) connection
{
    // We are getting a string from the connection, lets mutate the NSMutableData to NSString
    NSString *string = [[NSString alloc] initWithData:m_data  encoding: NSASCIIStringEncoding];
    
    // Set the UITextArea? text to the NSString received.
    texto.text = string;
    
    // Dismiss the alert.
    [m_alert dismissWithClickedButtonIndex:0 animated:YES];
    
    // This UIAlertView is not used anymore, so it will be derezed.
    m_alert = nil;
}

@end
