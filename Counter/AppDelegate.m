//
//  AppDelegate.m
//  Counter
//
//  Created by Ian Gregory on 31-10-2016.
//  Copyright © 2016 ThatsJustCheesy. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property(nonatomic,weak) IBOutlet NSWindow *window;

@property(nonatomic) NSInteger count;
@property(nonatomic) BOOL displayCountInDock;

@end

@implementation AppDelegate

- (void)updateCountString {
    self.countString = [NSString stringWithFormat:@"%li", self.count];
    NSApp.dockTile.badgeLabel = (self.displayCountInDock) ? self.countString : nil;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (context != (__bridge void*)self) {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        return;
    }
    
    if ([keyPath isEqualToString:@"count"]) {
        [self updateCountString];
    }
    else if ([keyPath isEqualToString:@"displayCountInDock"]) {
        [self updateCountString];
    }
}

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
    [self addObserver:self forKeyPath:@"count" options:0 context:(__bridge void*)self];
    [self addObserver:self forKeyPath:@"displayCountInDock" options:0 context:(__bridge void*)self];
    
    self.count = 0;
    self.displayCountInDock = YES;
}

- (void)mouseDown:(NSEvent *)event {
    self.count++;
}

- (void)rightMouseDown:(NSEvent *)event {
    self.count--;
}

- (IBAction)increaseCount:(id)sender {
    self.count++;
}

- (IBAction)decreaseCount:(id)sender {
    self.count--;
}

- (IBAction)increaseCountBy5:(id)sender {
    self.count += 5;
}

- (IBAction)decreaseCountBy5:(id)sender {
    self.count -= 5;
}

- (IBAction)zeroCount:(id)sender {
    self.count = 0;
}

@end
