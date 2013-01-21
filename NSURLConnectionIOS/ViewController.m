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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // No se puede editar el texto
	[texto setEditable:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)obtenerTexto:(id)sender
{
    UIAlertView *alert;
    alert = [[UIAlertView alloc] initWithTitle:@"Espera" message:@"Estamos descargando el texto" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    UIActivityIndicatorView *spinner;
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    NSURL *url = [NSURL URLWithString: @"http://otfusion.org/if.html"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if(connection) {
        m_data = [NSMutableData data];
        [alert show];
        spinner.center = CGPointMake(alert.bounds.size.width/2, alert.bounds.size.height - 50);
        
        [alert addSubview:spinner];
        [spinner startAnimating];
        m_alert = alert;
    } else {
        alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No nos pudimos conectar" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

- (void) connection: (NSURLConnection *) connection
 didReceiveResponse: (NSURLResponse *) response
{
    [m_data setLength:0];
}

- (void) connection:  (NSURLConnection *) connection  didReceiveData: (NSData *) data
{
    [m_data appendData:data];
}

- (void) connection: (NSURLConnection *) connection  didFailWithError: (NSError *) error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ERROR" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert dismissWithClickedButtonIndex:0 animated:YES];
}

- (void) connectionDidFinishLoading: (NSURLConnection *) connection
{
    NSString *string = [[NSString alloc] initWithData:m_data  encoding: NSASCIIStringEncoding];
    texto.text = string;
    [m_alert dismissWithClickedButtonIndex:0 animated:YES];
    m_alert = nil;
}

@end
