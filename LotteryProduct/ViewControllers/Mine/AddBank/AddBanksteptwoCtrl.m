//
//  AddBanksteptwoCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/7/20.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "AddBanksteptwoCtrl.h"

@interface AddBanksteptwoCtrl ()

@property (weak, nonatomic) IBOutlet UITextField *cardtypefield;
@property (weak, nonatomic) IBOutlet UITextField *phonefield;
@property (weak, nonatomic) IBOutlet UITextField *testfield;

@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@end

@implementation AddBanksteptwoCtrl

- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self refreshnextBtn];
    
    [self.cardtypefield addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.phonefield addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.testfield addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.cardtypefield.text = self.cardname;
    self.cardtypefield.enabled = NO;
}

- (IBAction)getCodeClick:(Timebtn *)sender {
    
    
}

- (IBAction)nextClick:(UIButton *)sender {
    
    @weakify(self)
    [WebTools postWithURL:@"/withdraw/adduserBankcard.json" params:@{@"cardNumber":self.cardnum} success:^(BaseData *data) {
        
        [MBProgressHUD showSuccess:data.info finish:^{
            @strongify(self)

            NSInteger index = [self.navigationController.viewControllers indexOfObject:self];
            
            [[NSNotificationCenter defaultCenter]postNotificationName:kUpdateAddBankNotification object:nil];
            
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:index-2] animated:YES];
        }];
        
    } failure:^(NSError *error) {
        
    }];
}

-(void)textFieldDidChange :(UITextField *)theTextField{
    NSLog( @"text changed: %@", theTextField.text);
    
    [self refreshnextBtn];
}



-(void)refreshnextBtn {
    
    if ([Tools isEmptyOrNull:self.cardtypefield.text] || [Tools isEmptyOrNull:self.phonefield.text] || [Tools isEmptyOrNull:self.testfield.text]) {

        self.nextBtn.enabled = NO;
        self.nextBtn.backgroundColor = [UIColor colorWithHex:@"DDDDDD"];
    }
    else {
        self.nextBtn.enabled = YES;
        self.nextBtn.backgroundColor = BUTTONCOLOR;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
