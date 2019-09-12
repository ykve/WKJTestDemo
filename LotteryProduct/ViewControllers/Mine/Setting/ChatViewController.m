/************************************************************
 *  * Hyphenate CONFIDENTIAL
 * __________________
 * Copyright (C) 2016 Hyphenate Inc. All rights reserved.
 *
 * NOTICE: All information contained herein is, and remains
 * the property of Hyphenate Inc.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from Hyphenate Inc.
 */

#import "ChatViewController.h"

#if DEMO_CALL == 1
#import "DemoConfManager.h"
#endif

@interface ChatViewController ()<UIAlertViewDelegate,EMClientDelegate>
{
    UIMenuItem *_copyMenuItem;
    UIMenuItem *_deleteMenuItem;
    UIMenuItem *_transpondMenuItem;
    UIMenuItem *_recallItem;
}

@property (nonatomic) BOOL isPlayingAudio;

@property (nonatomic) NSMutableDictionary *emotionDic;

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [ChatDemoHelper shareHelper].chatVC = self;
    
    
    self.delegate = self;
    self.dataSource = self;
    [self _setupBarButtonItem];
   
    if (self.conversation.type == EMConversationTypeChat) {
        NSUserDefaults *uDefaults = [NSUserDefaults standardUserDefaults];
        BOOL isTyping = [uDefaults boolForKey:@"MessageShowTyping"];
        if (isTyping) {
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[EMClient sharedClient].chatManager deleteConversation:self.conversation.conversationId isDeleteMessages:YES completion:nil];
    
    [[EMClient sharedClient] removeDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.conversation.type == EMConversationTypeGroupChat) {
        NSDictionary *ext = self.conversation.ext;
        if ([[ext objectForKey:@"subject"] length])
        {
            self.title = [ext objectForKey:@"subject"];
        }
        
        if (ext && ext[kHaveUnreadAtMessage] != nil)
        {
            NSMutableDictionary *newExt = [ext mutableCopy];
            [newExt removeObjectForKey:kHaveUnreadAtMessage];
            self.conversation.ext = newExt;
        }
    }
}

- (void)tableViewDidTriggerHeaderRefresh
{
    [super tableViewDidTriggerHeaderRefresh];
}

#pragma mark - setup subviews

- (void)_setupBarButtonItem
{
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    backButton.accessibilityIdentifier = @"back";
    [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:backItem];
    
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.cancelButtonIndex != buttonIndex) {
        self.messageTimeIntervalTag = -1;
        [self.conversation deleteAllMessages:nil];
        [self.dataArray removeAllObjects];
        [self.messsagesSource removeAllObjects];
        
        [self.tableView reloadData];
    }
}


#pragma mark - EaseMessageViewControllerDelegate

- (UITableViewCell *)messageViewController:(UITableView *)tableView
                       cellForMessageModel:(id<IMessageModel>)messageModel
{
    NSDictionary *ext = messageModel.message.ext;
    if ([ext objectForKey:@"em_recall"]) {
        NSString *TimeCellIdentifier = [EaseMessageTimeCell cellIdentifier];
        EaseMessageTimeCell *recallCell = (EaseMessageTimeCell *)[tableView dequeueReusableCellWithIdentifier:TimeCellIdentifier];
        
        if (recallCell == nil) {
            recallCell = [[EaseMessageTimeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TimeCellIdentifier];
            recallCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        EMTextMessageBody *body = (EMTextMessageBody*)messageModel.message.body;
        recallCell.title = body.text;
        return recallCell;
    }
    return nil;
}

- (CGFloat)messageViewController:(EaseMessageViewController *)viewController
           heightForMessageModel:(id<IMessageModel>)messageModel
                   withCellWidth:(CGFloat)cellWidth
{
    NSDictionary *ext = messageModel.message.ext;
    if ([ext objectForKey:@"em_recall"]) {
        return self.timeCellHeight;
    }
    return 0;
}

- (BOOL)messageViewController:(EaseMessageViewController *)viewController
   canLongPressRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (BOOL)messageViewController:(EaseMessageViewController *)viewController
   didLongPressRowAtIndexPath:(NSIndexPath *)indexPath
{
    id object = [self.dataArray objectAtIndex:indexPath.row];
    if (![object isKindOfClass:[NSString class]]) {
        EaseMessageCell *cell = (EaseMessageCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        if ([cell isKindOfClass:[EaseMessageCell class]]) {
            [cell becomeFirstResponder];
            self.menuIndexPath = indexPath;
            [self showMenuViewController:cell.bubbleView andIndexPath:indexPath messageType:cell.model.bodyType];
        }
    }
    return YES;
}

- (void)messageViewController:(EaseMessageViewController *)viewController
  didSelectAvatarMessageModel:(id<IMessageModel>)messageModel
{
    UserProfileViewController *userprofile = [[UserProfileViewController alloc] initWithUsername:messageModel.message.from];
    [self.navigationController pushViewController:userprofile animated:YES];
}

- (void)messageViewController:(EaseMessageViewController *)viewController
    didSelectCallMessageModel:(id<IMessageModel>)messageModel
{
#if DEMO_CALL == 1
    [[DemoConfManager sharedManager] handleMessageToJoinConference:messageModel.message];
#endif
}

- (void)messageViewController:(EaseMessageViewController *)viewController
               selectAtTarget:(EaseSelectAtTargetCallback)selectedCallback
{
    _selectedCallback = selectedCallback;
    EMGroup *chatGroup = nil;
    NSArray *groupArray = [[EMClient sharedClient].groupManager getJoinedGroups];
    for (EMGroup *group in groupArray) {
        if ([group.groupId isEqualToString:self.conversation.conversationId]) {
            chatGroup = group;
            break;
        }
    }
    
    if (chatGroup == nil) {
        chatGroup = [EMGroup groupWithId:self.conversation.conversationId];
    }
    
    if (chatGroup) {
        if (!chatGroup.occupants) {
            __weak ChatViewController* weakSelf = self;
            [self showHudInView:self.view hint:@"Fetching group members..."];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                EMError *error = nil;
                EMGroup *group = [[EMClient sharedClient].groupManager getGroupSpecificationFromServerWithId:chatGroup.groupId error:&error];
                dispatch_async(dispatch_get_main_queue(), ^{
                    __strong ChatViewController *strongSelf = weakSelf;
                    if (strongSelf) {
                        [strongSelf hideHud];
                        if (error) {
                            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"Fetching group members failed [%@]", error.errorDescription] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                            [alertView show];
                        }
                        else {
                            NSMutableArray *members = [group.occupants mutableCopy];
                            NSString *loginUser = [EMClient sharedClient].currentUsername;
                            if (loginUser) {
                                [members removeObject:loginUser];
                            }
                            if (![members count]) {
                                if (strongSelf.selectedCallback) {
                                    strongSelf.selectedCallback(nil);
                                }
                                return;
                            }
                            ContactSelectionViewController *selectController = [[ContactSelectionViewController alloc] initWithContacts:members];
                            selectController.mulChoice = NO;
                            selectController.delegate = self;
                            [self.navigationController pushViewController:selectController animated:YES];
                        }
                    }
                });
            });
        }
        else {
            NSMutableArray *members = [chatGroup.occupants mutableCopy];
            NSString *loginUser = [EMClient sharedClient].currentUsername;
            if (loginUser) {
                [members removeObject:loginUser];
            }
            if (![members count]) {
                if (_selectedCallback) {
                    _selectedCallback(nil);
                }
                return;
            }
            ContactSelectionViewController *selectController = [[ContactSelectionViewController alloc] initWithContacts:members];
            selectController.mulChoice = NO;
            selectController.delegate = self;
            [self.navigationController pushViewController:selectController animated:YES];
        }
    }
}

#pragma mark - EaseMessageViewControllerDataSource

- (id<IMessageModel>)messageViewController:(EaseMessageViewController *)viewController
                           modelForMessage:(EMMessage *)message
{
    id<IMessageModel> model = nil;
    model = [[EaseMessageModel alloc] initWithMessage:message];
    model.avatarImage = [UIImage imageNamed:@"EaseUIResource.bundle/user"];
    UserProfileEntity *profileEntity = [[UserProfileManager sharedInstance] getUserProfileByUsername:model.nickname];
    if (profileEntity) {
        model.avatarURLPath = profileEntity.imageUrl;
        model.nickname = profileEntity.nickname;
    }
    model.failImageName = @"imageDownloadFail";
    
    model.isDing = [EMDingMessageHelper isDingMessage:message];
    model.dingReadCount = [[EMDingMessageHelper sharedHelper] dingAckCount:message];
    return model;
}

- (NSArray*)emotionFormessageViewController:(EaseMessageViewController *)viewController
{
    NSMutableArray *emotions = [NSMutableArray array];
    for (NSString *name in [EaseEmoji allEmoji]) {
        EaseEmotion *emotion = [[EaseEmotion alloc] initWithName:@"" emotionId:name emotionThumbnail:name emotionOriginal:name emotionOriginalURL:@"" emotionType:EMEmotionDefault];
        [emotions addObject:emotion];
    }
    EaseEmotion *temp = [emotions objectAtIndex:0];
    EaseEmotionManager *managerDefault = [[EaseEmotionManager alloc] initWithType:EMEmotionDefault emotionRow:3 emotionCol:7 emotions:emotions tagImage:[UIImage imageNamed:temp.emotionId]];
    
    return @[managerDefault];
}

- (BOOL)isEmotionMessageFormessageViewController:(EaseMessageViewController *)viewController
                                    messageModel:(id<IMessageModel>)messageModel
{
    BOOL flag = NO;
    if ([messageModel.message.ext objectForKey:MESSAGE_ATTR_IS_BIG_EXPRESSION]) {
        return YES;
    }
    return flag;
}

//- (EaseEmotion*)emotionURLFormessageViewController:(EaseMessageViewController *)viewController
//                                      messageModel:(id<IMessageModel>)messageModel
//{
//    NSString *emotionId = [messageModel.message.ext objectForKey:MESSAGE_ATTR_EXPRESSION_ID];
//    EaseEmotion *emotion = [_emotionDic objectForKey:emotionId];
//    if (emotion == nil) {
//        emotion = [[EaseEmotion alloc] initWithName:@"" emotionId:emotionId emotionThumbnail:@"" emotionOriginal:@"" emotionOriginalURL:@"" emotionType:EMEmotionGif];
//    }
//    return emotion;
//}

- (NSDictionary*)emotionExtFormessageViewController:(EaseMessageViewController *)viewController
                                        easeEmotion:(EaseEmotion*)easeEmotion
{
    return @{MESSAGE_ATTR_EXPRESSION_ID:easeEmotion.emotionId,MESSAGE_ATTR_IS_BIG_EXPRESSION:@(YES)};
}

- (void)messageViewControllerMarkAllMessagesAsRead:(EaseMessageViewController *)viewController
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"setupUnreadMessageCount" object:nil];
}

#pragma mark - EMClientDelegate

- (void)userAccountDidLoginFromOtherDevice
{
    if ([self.imagePicker.mediaTypes count] > 0 && [[self.imagePicker.mediaTypes objectAtIndex:0] isEqualToString:(NSString *)kUTTypeMovie]) {
        [self.imagePicker stopVideoCapture];
    }
}

- (void)userAccountDidRemoveFromServer
{
    if ([self.imagePicker.mediaTypes count] > 0 && [[self.imagePicker.mediaTypes objectAtIndex:0] isEqualToString:(NSString *)kUTTypeMovie]) {
        [self.imagePicker stopVideoCapture];
    }
}

- (void)userDidForbidByServer
{
    if ([self.imagePicker.mediaTypes count] > 0 && [[self.imagePicker.mediaTypes objectAtIndex:0] isEqualToString:(NSString *)kUTTypeMovie]) {
        [self.imagePicker stopVideoCapture];
    }
}

#pragma mark - EMChatManagerDelegate

- (void)messagesDidRecall:(NSArray *)aMessages
{
    for (EMMessage *msg in aMessages) {
        if (![self.conversation.conversationId isEqualToString:msg.conversationId]){
            continue;
        }
        
        NSString *text;
        if ([msg.from isEqualToString:[EMClient sharedClient].currentUsername]) {
            text = [NSString stringWithFormat:NSLocalizedString(@"message.recall", @"You recall a message")];
        } else {
            text = [NSString stringWithFormat:NSLocalizedString(@"message.recallByOthers", @"%@ recall a message"),msg.from];
        }
        
        [self _recallWithMessage:msg text:text isSave:NO];
    }
}

#pragma mark - EMChooseViewDelegate

- (BOOL)viewController:(EMChooseViewController *)viewController didFinishSelectedSources:(NSArray *)selectedSources
{
    if ([selectedSources count]) {
        EaseAtTarget *target = [[EaseAtTarget alloc] init];
        target.userId = selectedSources.firstObject;
        UserProfileEntity *profileEntity = [[UserProfileManager sharedInstance] getUserProfileByUsername:target.userId];
        if (profileEntity) {
            target.nickname = profileEntity.nickname == nil ? profileEntity.username : profileEntity.nickname;
        }
        if (_selectedCallback) {
            _selectedCallback(target);
        }
    }
    else {
        if (_selectedCallback) {
            _selectedCallback(nil);
        }
    }
    return YES;
}

- (void)viewControllerDidSelectBack:(EMChooseViewController *)viewController
{
    if (_selectedCallback) {
        _selectedCallback(nil);
    }
}

#pragma mark - KeyBoard

- (void)keyBoardWillHide:(NSNotification *)note
{
    NSString *from = [[EMClient sharedClient] currentUsername];
    
    EMCmdMessageBody *body = [[EMCmdMessageBody alloc] initWithAction:@"TypingEnd"];
    body.isDeliverOnlineOnly = YES;
    EMMessage *msg = [[EMMessage alloc] initWithConversationID:self.conversation.conversationId from:from to:self.conversation.conversationId body:body ext:nil];
    [[EMClient sharedClient].chatManager sendMessage:msg progress:nil completion:nil];
}

#pragma mark - action

- (void)backAction
{
    [ChatDemoHelper shareHelper].chatVC = nil;
    [[EMClient sharedClient].chatManager removeDelegate:self];
    [[EMClient sharedClient].roomManager removeDelegate:self];
    
    if (self.deleteConversationIfNull) {
        //判断当前会话是否为空，若符合则删除该会话
        EMMessage *message = [self.conversation latestMessage];
        if (message == nil) {
            [[EMClient sharedClient].chatManager deleteConversation:self.conversation.conversationId isDeleteMessages:NO completion:nil];
        }
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showGroupDetailAction
{
    [self.view endEditing:YES];
    
    if (self.conversation.type == EMConversationTypeGroupChat) {
        EMGroupInfoViewController *infoController = [[EMGroupInfoViewController alloc] initWithGroupId:self.conversation.conversationId];
        [self.navigationController pushViewController:infoController animated:YES];
    }
    else if (self.conversation.type == EMConversationTypeChatRoom)
    {
        ChatroomDetailViewController *detailController = [[ChatroomDetailViewController alloc] initWithChatroomId:self.conversation.conversationId];
        [self.navigationController pushViewController:detailController animated:YES];
    }
}

- (void)dingAction
{
    [self.view endEditing:YES];
    DingViewController *controller = [[DingViewController alloc] initWithConversationId:self.conversation.conversationId to:self.conversation.conversationId chatType:EMChatTypeGroupChat finishCompletion:^(EMMessage *aMessage) {
        [self sendMessage:aMessage isNeedUploadFile:NO];
    }];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)deleteAllMessages:(id)sender
{
    [[EMDingMessageHelper sharedHelper] deleteConversation:self.conversation.conversationId];
    
    if (self.dataArray.count == 0) {
        [self showHint:NSLocalizedString(@"message.noMessage", @"no messages")];
        return;
    }
    
    if ([sender isKindOfClass:[NSNotification class]]) {
        NSString *groupId = (NSString *)[(NSNotification *)sender object];
        BOOL isDelete = [groupId isEqualToString:self.conversation.conversationId];
        if (self.conversation.type != EMConversationTypeChat && isDelete) {
            self.messageTimeIntervalTag = -1;
            [self.conversation deleteAllMessages:nil];
            [self.messsagesSource removeAllObjects];
            [self.dataArray removeAllObjects];
            
            [self.tableView reloadData];
            [self showHint:NSLocalizedString(@"message.noMessage", @"no messages")];
        }
    }
    else if ([sender isKindOfClass:[UIButton class]]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompt", @"Prompt") message:NSLocalizedString(@"sureToDelete", @"please make sure to delete") delegate:self cancelButtonTitle:NSLocalizedString(@"cancel", @"Cancel") otherButtonTitles:NSLocalizedString(@"ok", @"OK"), nil];
        [alertView show];
    }
}

- (void)recallMenuAction:(id)sender
{
    if (self.menuIndexPath && self.menuIndexPath.row > 0) {
        __weak typeof(self) weakSelf = self;
        id<IMessageModel> model = [self.dataArray objectAtIndex:self.menuIndexPath.row];
        [[EMClient sharedClient].chatManager recallMessage:model.message
                                                completion:^(EMMessage *aMessage, EMError *aError) {
                                                    if (!aError) {
                                                        [weakSelf _recallWithMessage:aMessage text:NSLocalizedString(@"message.recall", @"You recall a message") isSave:YES];
                                                    } else {
                                                        [weakSelf showHint:[NSString stringWithFormat:NSLocalizedString(@"recallFailed", @"Recall failed:%@"), aError.errorDescription]];
                                                    }
                                                    weakSelf.menuIndexPath = nil;
                                                }];
    }
}

- (void)transpondMenuAction:(id)sender
{
    if (self.menuIndexPath && self.menuIndexPath.row > 0) {
        id<IMessageModel> model = [self.dataArray objectAtIndex:self.menuIndexPath.row];
        ContactListSelectViewController *listViewController = [[ContactListSelectViewController alloc] initWithNibName:nil bundle:nil];
        listViewController.messageModel = model;
        [listViewController tableViewDidTriggerHeaderRefresh];
        [self.navigationController pushViewController:listViewController animated:YES];
    }
    self.menuIndexPath = nil;
}

- (void)copyMenuAction:(id)sender
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    if (self.menuIndexPath && self.menuIndexPath.row > 0) {
        id<IMessageModel> model = [self.dataArray objectAtIndex:self.menuIndexPath.row];
        pasteboard.string = model.text;
    }
    
    self.menuIndexPath = nil;
}

- (void)deleteMenuAction:(id)sender
{
    if (self.menuIndexPath && self.menuIndexPath.row > 0) {
        id<IMessageModel> model = [self.dataArray objectAtIndex:self.menuIndexPath.row];
        NSMutableIndexSet *indexs = [NSMutableIndexSet indexSetWithIndex:self.menuIndexPath.row];
        NSMutableArray *indexPaths = [NSMutableArray arrayWithObjects:self.menuIndexPath, nil];
        
        [self.conversation deleteMessageWithId:model.message.messageId error:nil];
        [self.messsagesSource removeObject:model.message];
        
        [[EMDingMessageHelper sharedHelper] deleteConversation:self.conversation.conversationId message:model.message.messageId];
        
        if (self.menuIndexPath.row - 1 >= 0) {
            id nextMessage = nil;
            id prevMessage = [self.dataArray objectAtIndex:(self.menuIndexPath.row - 1)];
            if (self.menuIndexPath.row + 1 < [self.dataArray count]) {
                nextMessage = [self.dataArray objectAtIndex:(self.menuIndexPath.row + 1)];
            }
            if ((!nextMessage || [nextMessage isKindOfClass:[NSString class]]) && [prevMessage isKindOfClass:[NSString class]]) {
                [indexs addIndex:self.menuIndexPath.row - 1];
                [indexPaths addObject:[NSIndexPath indexPathForRow:(self.menuIndexPath.row - 1) inSection:0]];
            }
        }
        
        [self.dataArray removeObjectsAtIndexes:indexs];
        [self.tableView reloadData];
        
        if ([self.dataArray count] == 0) {
            self.messageTimeIntervalTag = -1;
        }
    }
    
    self.menuIndexPath = nil;
}

#pragma mark - NSNotification

- (void)exitChat
{
    [self.navigationController popToViewController:self animated:NO];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)insertCallMessage:(NSNotification *)notification
{
    id object = notification.object;
    if (object) {
        EMMessage *message = (EMMessage *)object;
        [self addMessageToDataSource:message progress:nil];
        [[EMClient sharedClient].chatManager importMessages:@[message] completion:nil];
    }
}

- (void)handleCallNotification:(NSNotification *)notification
{
    id object = notification.object;
    if ([object isKindOfClass:[NSDictionary class]]) {
        //开始call
        self.isViewDidAppear = NO;
    } else {
        //结束call
        self.isViewDidAppear = YES;
    }
}

#pragma mark - private

- (void)_recallWithMessage:(EMMessage *)msg text:(NSString *)text isSave:(BOOL)isSave
{
    EMMessage *message = [EaseSDKHelper getTextMessage:text to:msg.conversationId messageType:msg.chatType messageExt:@{@"em_recall":@(YES)}];
    message.isRead = YES;
    [message setTimestamp:msg.timestamp];
    [message setLocalTime:msg.localTime];
    id<IMessageModel> newModel = [[EaseMessageModel alloc] initWithMessage:message];
    __block NSUInteger index = NSNotFound;
    [self.dataArray enumerateObjectsUsingBlock:^(EaseMessageModel *model, NSUInteger idx, BOOL *stop){
        if ([model conformsToProtocol:@protocol(IMessageModel)]) {
            if ([msg.messageId isEqualToString:model.message.messageId])
            {
                index = idx;
                *stop = YES;
            }
        }
    }];
    if (index != NSNotFound) {
        __block NSUInteger sourceIndex = NSNotFound;
        [self.messsagesSource enumerateObjectsUsingBlock:^(EMMessage *message, NSUInteger idx, BOOL *stop){
            if ([message isKindOfClass:[EMMessage class]]) {
                if ([msg.messageId isEqualToString:message.messageId])
                {
                    sourceIndex = idx;
                    *stop = YES;
                }
            }
        }];
        if (sourceIndex != NSNotFound) {
            [self.messsagesSource replaceObjectAtIndex:sourceIndex withObject:newModel.message];
        }
        [self.dataArray replaceObjectAtIndex:index withObject:newModel];
        [self.tableView reloadData];
    }
    
    if (isSave) {
        [self.conversation insertMessage:message error:nil];
    }
}

#pragma mark - Public

- (void)showMenuViewController:(UIView *)showInView
                  andIndexPath:(NSIndexPath *)indexPath
                   messageType:(EMMessageBodyType)messageType
{
    if (self.menuController == nil) {
        self.menuController = [UIMenuController sharedMenuController];
    }
    
    if (_deleteMenuItem == nil) {
        _deleteMenuItem = [[UIMenuItem alloc] initWithTitle:NSLocalizedString(@"delete", @"Delete") action:@selector(deleteMenuAction:)];
    }
    
    if (_copyMenuItem == nil) {
        _copyMenuItem = [[UIMenuItem alloc] initWithTitle:NSLocalizedString(@"copy", @"Copy") action:@selector(copyMenuAction:)];
    }
    
    if (_transpondMenuItem == nil) {
        _transpondMenuItem = [[UIMenuItem alloc] initWithTitle:NSLocalizedString(@"transpond", @"Transpond") action:@selector(transpondMenuAction:)];
    }
    
    if (_recallItem == nil) {
        _recallItem = [[UIMenuItem alloc] initWithTitle:NSLocalizedString(@"recall", @"Recall") action:@selector(recallMenuAction:)];
    }
    
    NSMutableArray *items = [NSMutableArray array];
    
    if (messageType == EMMessageBodyTypeText) {
        [items addObject:_copyMenuItem];
        [items addObject:_transpondMenuItem];
        [items addObject:_deleteMenuItem];
    } else if (messageType == EMMessageBodyTypeImage || messageType == EMMessageBodyTypeVideo) {
        [items addObject:_transpondMenuItem];
        [items addObject:_deleteMenuItem];
    } else {
        [items addObject:_deleteMenuItem];
    }
    
    id<IMessageModel> model = [self.dataArray objectAtIndex:self.menuIndexPath.row];
    if (model.isSender) {
        [items addObject:_recallItem];
    }
    
    [self.menuController setMenuItems:items];
    [self.menuController setTargetRect:showInView.frame inView:showInView.superview];
    [self.menuController setMenuVisible:YES animated:YES];
}

- (void)reloadDingCellWithAckMessageId:(NSString *)aMessageId
{
    if ([aMessageId length] == 0) {
        return;
    }
    
    __block NSUInteger index = NSNotFound;
    __block EaseMessageModel *msgModel = nil;
    [self.dataArray enumerateObjectsUsingBlock:^(EaseMessageModel *model, NSUInteger idx, BOOL *stop){
        if ([model conformsToProtocol:@protocol(IMessageModel)] && [aMessageId isEqualToString:model.message.messageId]) {
            msgModel = model;
            index = idx;
            *stop = YES;
        }
    }];
    
    if (index != NSNotFound) {
        msgModel.dingReadCount += 1;
        [self.tableView beginUpdates];
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        [self.tableView endUpdates];
    }
}

@end
