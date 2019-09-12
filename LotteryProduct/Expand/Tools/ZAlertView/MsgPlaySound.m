//
//  MsgPlaySound.m
//  XueAn
//
//  Created by 1 on 2017/3/31.
//  Copyright © 2017年 1. All rights reserved.
//

#import "MsgPlaySound.h"

@implementation MsgPlaySound

- (id)initSystemShake
{
    self = [super init];
    if (self) {
        sound = kSystemSoundID_Vibrate;//震动
    }
    return self;
}

- (id)initSystemSoundWithName:(NSString *)soundName SoundType:(NSString *)soundType
{
    self = [super init];
    if (self) {
        if ([soundName isEqualToString:@"中奖"] || [soundName isEqualToString:@"开奖"]) {
            
            NSURL *path = [[NSBundle mainBundle] URLForResource: soundName withExtension: soundType];
            
            if (path) {
                OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)path,&sound);
                if (error != kAudioServicesNoError) {//获取的声音的时候，出现错误
                    sound = 0;
                }
            }
        }
        else{
            NSString *path = [NSString stringWithFormat:@"/System/Library/Audio/UISounds/%@.%@",soundName,soundType];
            if (path) {
                OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path],&sound);
                if (error != kAudioServicesNoError) {//获取的声音的时候，出现错误
                    sound = 0;
                }
            }
        }
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        [audioSession overrideOutputAudioPort:AVAudioSessionPortOverrideSpeaker error:nil];
        [audioSession setActive:YES error:nil];

        
        //[[NSBundle bundleWithIdentifier:@"com.apple.UIKit" ]pathForResource:soundName ofType:soundType];
        //得到苹果框架资源UIKit.framework ，从中取出所要播放的系统声音的路径
        //[[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];  获取自定义的声音
        
    }
    return self;
}

- (void)play
{
    AudioServicesPlaySystemSound(sound);
}

@end
