#import "EchoViewController.h"
#import "MTTransportObserver.h"
#import "MTTransportManager.h"



static NSString *const kEchoWebsocketTestServerURL = @"ws://echo.websocket.org/";



@interface EchoViewController () <MTTransportObserver>
@property (weak, nonatomic) MTTransportManager *transportManager;

@end



@implementation EchoViewController

- (void)dealloc
{

}

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSURL *URL = [NSURL URLWithString:kEchoWebsocketTestServerURL];
    MTTransportManager *transportManager = [MTTransportManager sharedTransportManager];
    [transportManager addObserver:self forURL:URL];
    [transportManager openTransportForURL:URL];
    self.transportManager = transportManager;
}



#pragma mark - IBAction
- (IBAction)didPressConnectButton:(id)sender
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (IBAction)didPressRepeatButton:(id)sender
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (IBAction)didPressSendButton:(id)sender
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (IBAction)editingDidBeginEchoTextField:(id)sender
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (IBAction)editingChangedEchoTextField:(id)sender
{
    NSLog(@"%s - %@", __PRETTY_FUNCTION__, sender);
}

- (IBAction)editingDidEndEchoTextField:(id)sender
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}





#pragma mark - MTTransportObserver
- (void)transportForURL:(NSURL *)aURL didReceiveMessageContent:(NSDictionary *)aMessageContent
{
    NSLog(@"%s - %@", __PRETTY_FUNCTION__, aMessageContent);
}
- (void)transportDidConnectForURL:(NSURL *)aURL
{
    [self.transportManager sendContent:@"Hello, World!" forURL:aURL];
}
- (void)transportDidCloseForURL:(NSURL *)aURL
{
    NSLog(@"%s - %@", __PRETTY_FUNCTION__, [aURL absoluteString]);
}
- (void)transportDidFailForURL:(NSURL *)aURL error:(NSError *)anError
{
    NSLog(@"%s - %@", __PRETTY_FUNCTION__, [aURL absoluteString]);
}

@end