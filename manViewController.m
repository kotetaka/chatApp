//
//  manViewController.m
//  chat
//
//  Created by 小寺 貴士 on 2012/09/10.
//  Copyright (c) 2012年 小寺 貴士. All rights reserved.
//

#import "manViewController.h"
#import "manTableCell.h"
#import "FaceViewController.h"

@interface manViewController ()

@end



@implementation manViewController


//文字表示
@synthesize huki;
@synthesize send;
@synthesize manTextField;
//@synthesize kousin;
//@synthesize manTextField;
@synthesize select;
@synthesize rootView;
@synthesize manTable;

//@synthesize ImageSelectdelegate;

UIImage* Face;
UIButton* moji;


FaceViewController *ModalViewController;

int c2 = 0;
int c3 = 0;
int c4 = 0;
int c5 = 0;
int c6 = 0;
int c7 = 0;
int c8 = 0;
int c9 = 0;
int c10 = 0;
int c11 = 0;
int c12 = 0;
int c13 = 0;

int faceNum = 0;
int count1 = 0;
int count2 = 0;
int count3 = 0;
int count4 = 0;
int count5 = 0;
int count6 = 0;
int count7 = 0;
int count8 = 0;
int count9 = 0;
int count10 = 0;
int count11 = 0;
int count12 = 0;
int count13 = 0;

int mark=0;
int up=-4;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        // ソフトキーボードの表示、非表示の通知を登録する
        NSNotificationCenter *center;
        center = [NSNotificationCenter defaultCenter];
        [center addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [center addObserver:self selector:@selector(keybaordWillHide:) name:UIKeyboardWillHideNotification object:nil];
        
    }
    return self;
}

- (id)init
{
    
    if ((self = [super init])) {
        
        self.view.backgroundColor = [UIColor grayColor];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [send setEnabled:NO];
    [send setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled]; //無効時
    [[moji layer] setCornerRadius:12.0];
    [moji setClipsToBounds:YES];
    
    
    UIImage *bgImage = [UIImage imageNamed:@"underPageBackground.png"];
    chatBox.backgroundColor=[UIColor colorWithPatternImage: bgImage];
    
    UIImage *bgvImage = [UIImage imageNamed:@"underPageBackground.png"];
    rootView.backgroundColor=[UIColor colorWithPatternImage: bgvImage];

    
    //ModalViewControllerの初期化
    ModalViewController  = [[FaceViewController alloc] init];
    ModalViewController.view.frame = self.view.frame;
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
       self.navigationItem.title = @"chat rooms";
    
    //chatlog初期化
    chatlog = [[NSMutableArray alloc] initWithObjects:nil];
    
    //imglog初期化
    imglog = [[NSMutableArray alloc]initWithObjects:nil];
    
    
    celllog = [[NSMutableArray alloc]initWithObjects:nil];

    //Noticelog = [[NSMutableArray alloc]initWithObjects:nil];
    
    manTextField.enablesReturnKeyAutomatically = YES;
    manText.delegate = self;

    //クリアボタンの表示
    manText.clearButtonMode =UITextFieldViewModeAlways;
    
    NSNotificationCenter *notification = [NSNotificationCenter defaultCenter];
    
    // キーボード表示時
    [notification addObserver:self selector:@selector(keyboardWillShow:)
						 name: UIKeyboardWillShowNotification object:nil];
    // キーボード非表示時
	[notification addObserver:self selector:@selector(keyboardWillHide:)
						 name: UIKeyboardWillHideNotification object:nil];
    // Do any additional setup after loading the view from its nib.
    //初期画像設定
    
    
    Face = [UIImage imageNamed:@"normal.png"];

    [[select layer] setCornerRadius:12.0];
    [select setClipsToBounds:YES];

    select.text = @"通常";

    
    _webSocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"ws://192.168.1.45:3000/"]]];
    [_webSocket setDelegate:self];
    [_webSocket open];
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	
    // OKが選択された場合
    if (buttonIndex == 1) {
        //[celllog addObject:@"5"];
        [manTextField resignFirstResponder];
        

        // テキストフィールドに一文字以上入力されていれば
        if ([textField.text length]) {
            
            // ボタンタイトルにテキストフィールドのテキストを設定
            [button setTitle:textField.text forState:UIControlStateNormal];
        }
    }
}


- (void)viewDidUnload
{
    [self setManTable:nil];
    chatBox = nil;
    
    //[self setManTextField:nil];
    
    _webSocket.delegate = nil;

    [_webSocket close];
    [self setSend:nil];
    [self setRootView:nil];

    [self setManTextField:nil];
    [self setSelect:nil];
    [self setHuki:nil];
    [super viewDidUnload];
    
    
   }


//mantextの入力文字数に合わせて無効/有効 高さ調整
/*- (void) textViewDidChange: (UITextView*) textView {
    manText.enablesReturnKeyAutomatically = YES;

    CGRect f = manText.frame;
     
    CGRect ch = Box.frame;

    if ([manText.text length] >=33 && [manText.text length] == 33 ) {
        f = CGRectMake(f.origin.x, f.origin.y, f.size.width, manText.contentSize.height+15);
        manText.frame = f;
        
        ch = CGRectMake(ch.origin.x, ch.origin.y-20, ch.size.width, Box.frame.size.height+28);
        Box.frame = ch;
        
    }
    else if (manText.text == @"\n"){
        f = CGRectMake(f.origin.x, f.origin.y, f.size.width, manText.contentSize.height+15);
        manText.frame = f;
        
        ch = CGRectMake(ch.origin.x, ch.origin.y-20, ch.size.width, Box.frame.size.height+28);
        Box.frame = ch;

    }
    else if ([manText.text length] >=66 && [manText.text length] ==66 ) {
        f = CGRectMake(f.origin.x, f.origin.y, f.size.width, manText.contentSize.height+15);
        manText.frame = f;
        
        ch = CGRectMake(ch.origin.x, ch.origin.y-40, ch.size.width, Box.frame.size.height+54);
        Box.frame = ch;
        
    }

    else if( [manText.text length] <33){
        manText.frame = f;
        Box.frame = ch;
    }
    
    if ([manText.text length] != 0) {
        [send setEnabled:YES];
        [send setTitleColor:[UIColor blackColor] forState:UIControlStateNormal]; //有効時
    }
    
    else if([manText.text length] == 0){
        [send setEnabled:NO];
        [send setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled]; //無効時
           }
}*/



- (IBAction)editingChanged {

    if ([manTextField.text length] != 0) {
        [send setEnabled:YES];
        [send setTitleColor:[UIColor blackColor] forState:UIControlStateNormal]; //有効時
        
    }
    else {
        [send setEnabled:NO];
        [send setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled]; //無効時
        
    }
    return;
}


//-- リターンキーがタップされたときキーボードを隠す処理
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    up++;
    mark++;
    [celllog addObject:@"1"];
    [chatlog addObject:manTextField.text];
    [imglog addObject:[[NSString alloc] initWithFormat:@"%d",faceNum]];
    [manTable reloadData];
    
    if(faceNum==0){
        count1 = count1+1;
        mark++;
        str = [[NSString alloc] initWithFormat:@"%@/%d:通常/1/%d回",manTextField.text,faceNum,count1];

    }else if(faceNum==1){
        count2 = count2+1;
        mark++;
        
        str = [[NSString alloc] initWithFormat:@"%@/%d:喜び/1/%d回",manTextField.text,faceNum,count2];
    }else if(faceNum==2){
        count3 = count3+1;
        mark++;
        
        str = [[NSString alloc] initWithFormat:@"%@/%d:安心/1/%d回",manTextField.text,faceNum,count3];
    }else if(faceNum==3){
        count4 = count4+1;
        str = [[NSString alloc] initWithFormat:@"%@/%d:満足/1/%d回",manTextField.text,faceNum,count4];
    }else if(faceNum==4){
        count5 = count5+1;
        mark++;
        
        str = [[NSString alloc] initWithFormat:@"%@/%d:リラックス/1/%d回",manTextField.text,faceNum,count5];
    }else if(faceNum==5){
        count6 = count6+1;
        mark++;
        
        str = [[NSString alloc] initWithFormat:@"%@/%d:興奮/1/%d回",manTextField.text,faceNum,count6];
    }else if(faceNum==6){
        count7 = count7+1;
        mark++;
        
        str = [[NSString alloc] initWithFormat:@"%@/%d:恐怖/1/%d回",manTextField.text,faceNum,count7];
    }else if(faceNum==7){
        count8 = count8+1;
        mark++;
        
        str = [[NSString alloc] initWithFormat:@"%@/%d:驚き/1/%d回",manTextField.text,faceNum,count8];
    }else if(faceNum==8){
        count9 = count9+1;
        mark++;
        
        str = [[NSString alloc] initWithFormat:@"%@/%d:不愉快/1/%d回",manTextField.text,faceNum,count9];
    }else if(faceNum==9){
        count10 = count10+1;
        mark++;
        
        str = [[NSString alloc] initWithFormat:@"%@/%d:怒り/1/%d回",manTextField.text,faceNum,count10];
    }else if(faceNum==10){
        count11 = count11+1;
        mark++;
        
        str = [[NSString alloc] initWithFormat:@"%@/%d:罪悪感/1/%d回",manTextField.text,faceNum,count11];
    }else if(faceNum==11){
        count12 = count12+1;
        mark++;
        
        str = [[NSString alloc] initWithFormat:@"%@/%d:憂鬱/1/%d回",manTextField.text,faceNum,count12];
    }else if(faceNum==12){
        count13 = count13+1;
        mark++;
        
        str = [[NSString alloc] initWithFormat:@"%@/%d:悲しみ/1/%d回",manTextField.text,faceNum,count13];
    }
    [manTextField resignFirstResponder];
    
    //    manText.frame.size.height == 35;
    int section = [manTable numberOfSections] - 1;
    int row = [manTable numberOfRowsInSection:section] - 1;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    [manTable scrollToRowAtIndexPath:indexPath
                    atScrollPosition:UITableViewScrollPositionBottom
                            animated:YES];
    
    [_webSocket send:str];
    //[manTable reloadData];
    
    huki.image=[UIImage imageNamed:@"huki12.png"];
    select.backgroundColor = RGB(158, 226, 90);
    
    
    /*manText.frame = CGRectMake(59, 13, 623, 35);
     
     chatBox.frame = CGRectMake(0,900,768,619);*/
    manTextField.text =nil;
    [send setEnabled:NO];
    
    return YES;
}

//背景がタップされた時の処理
- (IBAction)backgroundtap:(id)sender{
    [manTextField resignFirstResponder];
    int section = [manTable numberOfSections] - 1;
    int row = [manTable numberOfRowsInSection:section] - 1;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    [manTable scrollToRowAtIndexPath:indexPath
                    atScrollPosition:UITableViewScrollPositionBottom
                            animated:YES];
}

- (IBAction)total:(id)sender {
    str = [[NSString alloc] initWithFormat:@"A:通常:%d回/喜び:%d回,変化:%d回 /安心:%d回,変化:%d回 /満足:%d回,変化:%d回 /リラックス:%d回,変化:%d回 /興奮:%d回,変化:%d回 /恐怖:%d回,変化:%d回 /驚き:%d回,変化:%d回 /不愉快:%d回,変化:%d回 /怒り:%d回,変化:%d回 /罪悪感:%d回,変化:%d回 /憂鬱:%d回,変化:%d回 /悲しみ:%d回,変化:%d回",count1,count2,c2,count3,c3,count4,c4,count5,c5,count6,c6,count7,c7,count8,c8,count9,c9,count10,c10,count11,c11,count12,c12,count13,c13];
    [_webSocket send:str];
    
}


//-- ボタンがタップされた時の処理
- (IBAction)btn:(id)sender {
    up++;
    mark++;
    [celllog addObject:@"1"];
    [chatlog addObject:manTextField.text];
    [imglog addObject:[[NSString alloc] initWithFormat:@"%d",faceNum]];
    [manTable reloadData];
    if(faceNum==0){
       count1 = count1+1;
        mark++;
    str = [[NSString alloc] initWithFormat:@"%@/%d:通常/1/%d回",manTextField.text,faceNum,count1];
        faceNum =0;
    }else if(faceNum==1){
        count2 = count2+1;
        mark++;

        str = [[NSString alloc] initWithFormat:@"%@/%d:喜び/1/%d回",manTextField.text,faceNum,count2];
    }else if(faceNum==2){
        count3 = count3+1;
        mark++;

        str = [[NSString alloc] initWithFormat:@"%@/%d:安心/1/%d回",manTextField.text,faceNum,count3];
    }else if(faceNum==3){
        count4 = count4+1;
        str = [[NSString alloc] initWithFormat:@"%@/%d:満足/1/%d回",manTextField.text,faceNum,count4];
        
    }else if(faceNum==4){
        count5 = count5+1;
        mark++;

        str = [[NSString alloc] initWithFormat:@"%@/%d:リラックス/1/%d回",manTextField.text,faceNum,count5];
    }else if(faceNum==5){
        count6 = count6+1;
        mark++;

        str = [[NSString alloc] initWithFormat:@"%@/%d:興奮/1/%d回",manTextField.text,faceNum,count6];
    }else if(faceNum==6){
        count7 = count7+1;
        mark++;

        str = [[NSString alloc] initWithFormat:@"%@/%d:恐怖/1/%d回",manTextField.text,faceNum,count7];
    }else if(faceNum==7){
        count8 = count8+1;
        mark++;

        str = [[NSString alloc] initWithFormat:@"%@/%d:驚き/1/%d回",manTextField.text,faceNum,count8];
    }else if(faceNum==8){
        count9 = count9+1;
        mark++;

        str = [[NSString alloc] initWithFormat:@"%@/%d:不愉快/1/%d回",manTextField.text,faceNum,count9];
    }else if(faceNum==9){
        count10 = count10+1;
        mark++;

        str = [[NSString alloc] initWithFormat:@"%@/%d:怒り/1/%d回",manTextField.text,faceNum,count10];
    }else if(faceNum==10){
        count11 = count11+1;
        mark++;

        str = [[NSString alloc] initWithFormat:@"%@/%d:罪悪感/1/%d回",manTextField.text,faceNum,count11];
    }else if(faceNum==11){
        count12 = count12+1;
        mark++;

        str = [[NSString alloc] initWithFormat:@"%@/%d:憂鬱/1/%d回",manTextField.text,faceNum,count12];
    }else if(faceNum==12){
        count13 = count13+1;
        mark++;

        str = [[NSString alloc] initWithFormat:@"%@/%d:悲しみ/1/%d回",manTextField.text,faceNum,count13];
    }
       [manTextField resignFirstResponder];
    
//    manText.frame.size.height == 35;
    int section = [manTable numberOfSections] - 1;
    int row = [manTable numberOfRowsInSection:section] - 1;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    [manTable scrollToRowAtIndexPath:indexPath
                    atScrollPosition:UITableViewScrollPositionBottom
                            animated:YES];
    
    [_webSocket send:str];
    manTextField.text =nil;
    [send setEnabled:NO];
    
    huki.image=[UIImage imageNamed:@"huki12.png"];
    select.backgroundColor = RGB(158, 226, 90);
    
         }


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

// セクション数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
;
}

//テーブルビュー
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //セルの高さをUILabelに合わせて設定
    NSString *newcellHeight = [chatlog objectAtIndex:indexPath.row];
    CGSize size = [newcellHeight sizeWithFont:[UIFont systemFontOfSize:15.0] constrainedToSize:CGSizeMake(140, 5000) lineBreakMode:NSLineBreakByWordWrapping];
    
    if(size.height-100>0){
        return size.height+55;
	}
    else{
        return 140;
    }

     
}


- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    
    return [chatlog count];
    
}

//manTableCellを引用させる
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CustomCell = @"EnterTableCell";
    
    if ([[celllog objectAtIndex:indexPath.row] intValue] == 1) {
        CustomCell = @"manTableCell";
    }else if ([[celllog objectAtIndex:indexPath.row] intValue] == 3) {
        CustomCell = @"partnerTableCell";
        
    }else if ([[celllog objectAtIndex:indexPath.row] intValue] == 2) {
        CustomCell = @"womanTableCell";
    }else if ([[celllog objectAtIndex:indexPath.row] intValue] == 4){
        CustomCell = @"wopartnerTableCell";
    }
    else if ([[celllog objectAtIndex:indexPath.row] intValue] == 5 ) {
    CustomCell = @"EnterTableCell";
    }
    else if ([[celllog objectAtIndex:indexPath.row] intValue] == 6){
    CustomCell = @"RetireTableCell";
    }

    
    
    manTableCell* cell = (manTableCell *)[tableView dequeueReusableCellWithIdentifier:CustomCell];

    if (cell == nil) {
        UIViewController* vc = [[UIViewController alloc] initWithNibName:CustomCell bundle:nil];
        cell = (manTableCell*)vc;
    }
    
    
    cell.manImage.image = [FaceViewController getImage:[[imglog objectAtIndex:indexPath.row] intValue]];
    
    cell.ManLabel.text =  [chatlog objectAtIndex:indexPath.row];
    
    cell.parLabel.text = [chatlog objectAtIndex:indexPath.row];

   
    
    [[cell.ManLabel layer] setCornerRadius:12.0];
    [cell.ManLabel setClipsToBounds:YES];

    
    [[cell.parLabel layer] setCornerRadius:12.0];
    [cell.parLabel setClipsToBounds:YES];
    
    [[cell.enter layer] setCornerRadius:12.0];
    [cell.enter setClipsToBounds:YES];
    
    [[cell.retire layer] setCornerRadius:12.0];
    [cell.retire setClipsToBounds:YES];
    
    
    
    //青判定を消す
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
             //  NSLog(@"%d",[cell.parLabel.text length]);
    
    
        if ([cell.parLabel.text length] < 17 ) {
            cell.parLabel.frame  = CGRectMake(644-[cell.parLabel.text length]*27,13,[cell.parLabel.text length]*27, 50);
        
        //cell.parLabel.textAlignment = UITextAlignmentRight;
        }
      /*  else if ([cell.parLabel.text length] <= 18 && @"\n") {
            cell.parLabel.frame  = CGRectMake(152,13,496, 100);
           // [cell.parLabel sizeToFit];
            //cell.parLabel.textAlignment = UITextAlignmentRight;
        }
        else if ([cell.parLabel.text length] >= 19 && @"\n") {
            cell.parLabel.frame  = CGRectMake(152,13,496, 100);

          //  [cell.parLabel sizeToFit];

        }*/
        else if ([cell.parLabel.text length] >= 17 ) {
            cell.parLabel.frame  = CGRectMake(212,13,452, 50);
            
              [cell.parLabel sizeToFit];
            
        }
    
                //NSLog(@"len:%d",[cell.parLabel.text length]);
        //[cell.parLabel setTextAlignment:UITextAlignmentRight];
        
    

    
        cell.ManLabel.frame  = CGRectMake(125, 13,452, 50);
        [cell.ManLabel sizeToFit];
    
   
    //改行モード（ここでは単語がおさまらなかったら単語毎改行）
    cell.ManLabel.lineBreakMode  = NSLineBreakByWordWrapping;
    cell.parLabel.lineBreakMode  = NSLineBreakByWordWrapping;

    //行数　行数制限なしにする
    cell.ManLabel.numberOfLines  = 0;
    cell.parLabel.numberOfLines  = 0;

    //サイズ　幅が大事（幅を指定しなかったら改行コード\nでしか改行しない）高さは後で変わるので適当。x、yはご希望の位置に

   

    NSLog(@"Face:%d",[[imglog objectAtIndex:indexPath.row] intValue]);
 
    return cell;
    
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
//キーボードの表示
-(void)keyboardWillShow:(NSNotification *)notificatioin
{
    // ここでTextFieldやTextViewの位置を変更する
   
   // NSLog(@"keyboardWillShow");
    NSLog(@"mark:%d",mark);
    if(mark>=8){
        NSLog(@"up:%d",up);
        
        float key_y = 140*up;
        
        CGPoint scrollPoint = CGPointMake(0.0,key_y);
        [manTable setContentOffset:scrollPoint animated:YES];
    }
       // キーボードに合わせたアニメーション処理
    [UIView animateWithDuration:0.3f
                     animations:^{
                         
                         // TextFieldのframe
                         CGRect viewRect  = chatBox.frame;
                         
                         // キーボードのサイズを取得
                         CGRect keybord;
                         [[notificatioin.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keybord];
                         
                         // TextFieldの位置から(元のY座標+TextViewの高さ) - (Viewの高さ - キーボード)分、上げる(マイナスする)
                         //viewRect.origin.y -= ((266.0f+viewRect.size.height)-(self.view.frame.size.height - keybord.size.height));
                         
                         //Viewの高さ - キーボードの高さ - TextViewの高さを引いて、その位置にする
                         viewRect.origin.y = 1520 - keybord.size.height - viewRect.size.height;
                         chatBox.frame = viewRect;
                     }];
}

/*
 *  キーボード非表示
 */
- (void)keyboardWillHide:(NSNotification *)notificatioin
{
    // ここでTextFieldやTextViewの位置を戻す
  //  NSLog(@"keyboardWillHide");
    
    // キーボードに合わせたアニメーション処理
    [UIView animateWithDuration:0.3f
                     animations:^{
                         
                         // TextFieldのframe
                         CGRect viewRect  = chatBox.frame;
                         
                         // TextFieldのY座標を元の位置に定義
                         viewRect.origin.y = 900.0f;
                         chatBox.frame = viewRect;
                     }];
    
}

//ModalViewの呼び出し
- (IBAction)FaceButton:(id)sender {
       
    ModalViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ModalView"];
   
    ModalViewController.ImageSelectdelegate_ = self;
    //   [self presentModalViewController:ModalViewController animated:YES];
    
}

-(void)selectImage:(int)num {
    faceNum = num;
    if (faceNum ==1) {
        select.text =@"喜び";
        huki.image = [UIImage imageNamed:@"huki13.png"];
        select.backgroundColor = RGB(254, 175, 220);
        c2 ++;

    }
    else if(faceNum ==2){
        select.text=@"安心";
        huki.image = [UIImage imageNamed:@"huki13.png"];
        select.backgroundColor = RGB(254, 175, 220);
        c3 ++;

    }else if(faceNum ==3){
        select.text=@"満足";
        huki.image = [UIImage imageNamed:@"huki13.png"];
        select.backgroundColor = RGB(254, 175, 220);
        c4 ++;

    }else if(faceNum ==4){
        select.text=@"リラックス";
        huki.image = [UIImage imageNamed:@"huki13.png"];
        select.backgroundColor = RGB(254, 175, 220);
        c5 ++;

    }else if(faceNum ==5){
        select.text=@"興奮";
        huki.image = [UIImage imageNamed:@"huki13.png"];
        select.backgroundColor = RGB(254, 175, 220);
        c6 ++;

    }else if(faceNum ==6){
        select.text=@"恐怖";
        huki.image = [UIImage imageNamed:@"huki13.png"];
        select.backgroundColor = RGB(254, 175, 220);
        c7 ++;

    }else if(faceNum ==7){
        select.text=@"驚き";
        huki.image = [UIImage imageNamed:@"huki13.png"];
        select.backgroundColor = RGB(254, 175, 220);
        c8 ++;

    }else if(faceNum ==8){
        select.text=@"不愉快";
        huki.image = [UIImage imageNamed:@"huki13.png"];
        select.backgroundColor = RGB(254, 175, 220);
        c9 ++;

    }else if(faceNum ==9){
        select.text=@"怒り";
        huki.image = [UIImage imageNamed:@"huki13.png"];
        select.backgroundColor = RGB(254, 175, 220);
        c10 ++;

    }else if(faceNum ==10){
        select.text=@"罪悪感";
        huki.image = [UIImage imageNamed:@"huki13.png"];
        select.backgroundColor = RGB(254, 175, 220);
        c11 ++;

    }else if(faceNum ==11){
        select.text=@"憂鬱";
        huki.image = [UIImage imageNamed:@"huki13.png"];
        select.backgroundColor = RGB(254, 175, 220);
        c12 ++;

    }else if(faceNum ==12){
        select.text=@"悲しみ";
        huki.image = [UIImage imageNamed:@"huki13.png"];
        select.backgroundColor = RGB(254, 175, 220);
        c13 ++;

    }

}

- (void)webSocketDidOpen:(SRWebSocket *)webSocket;
{
    NSLog(@"Websocket Connected");
     count1 = 0;
     count2 = 0;
     count3 = 0;
     count4 = 0;
     count5 = 0;
     count6 = 0;
     count7 = 0;
     count8 = 0;
     count9 = 0;
     count10 = 0;
     count11 = 0;
     count12 = 0;
     count13 = 0;
    self.title = @"接続に成功しました!";
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error;
{
    NSLog(@":( Websocket Failed With Error %@", error);
       self.title = @"Connection Failed! (see logs)";

    _webSocket = nil;
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message;
{
    up++;
    mark++;

    //messageの初期化
    NSString *mstr = [[NSString alloc] initWithFormat:@"%@",message];
    NSArray *mesArr = [mstr componentsSeparatedByString:@"/"];
    //NSLog(@"Received \"%@\"", mstr);
    [chatlog addObject:[mesArr objectAtIndex:0]];
    
    //img = Face;
    [imglog addObject:[mesArr objectAtIndex:1]];
    //[imglog addObject:img];
    NSLog(@"%d",[[mesArr objectAtIndex:2] intValue]+2);
    [celllog addObject:[[NSString alloc] initWithFormat:@"%d",[[mesArr objectAtIndex:2] intValue]+2]];

    [manTable reloadData];

    int section = [manTable numberOfSections] - 1;
    int row = [manTable numberOfRowsInSection:section] - 1;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    [manTable scrollToRowAtIndexPath:indexPath
                    atScrollPosition:UITableViewScrollPositionMiddle
                            animated:YES];
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean;
{
    NSLog(@"WebSocket closed");
    self.title = @"Connection Closed! (see logs)";
    _webSocket = nil;
}


@end
