//
//  LoginViewController.m
//  Trade
//
//  Created by Yuyangdexue on 15/10/27.
//  Copyright © 2015年 yuyang. All rights reserved.
//

#import "LoginViewController.h"
#import "CustomTextField.h"
#import "Constants.h"
#import "Utilities.h"
#import "AppDelegate.h"
#import "RegisterViewController.h"
#define kHeight  300
#define kEdgeWith  50
@interface LoginViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIScrollView *_scrollView;
    UIButton     *_avatarBtn;
    CustomTextField *_userTextField;
    CustomTextField *_emailTextField;
    CustomTextField *_passwordTextField;
    UIButton        *_loginBtn;
    UIButton        *_forgetBtn;
    UIImagePickerController *imagePicker;
    UIImage *theImage;
  
}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.view addSubview:self.scrollView];
    [_scrollView addSubview:self.bgImage];
    //[_scrollView addSubview:self.avatarBtn];
    [_scrollView addSubview:self.userTextField];
    //[_scrollView addSubview:self.emailTextField];
    [_scrollView addSubview:self.passwordTextField];
    [_scrollView addSubview:self.loginBtn];
    [_scrollView addSubview:self.forgetPasswordBtn];
   
}


- (void)upData
{
//    AFHTTPRequestOperationManager *manager =
//    [AFHTTPRequestOperationManager manager];
//    
//    manager.responseSerializer.acceptableContentTypes =
//    [NSSet setWithObjects:@"application/json", @"text/json", @"text/plain",
//     @"text/html", nil];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    
//    NSDictionary *parmarm;
//    [manager POST:@"" parameters:parmarm constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        
//        if (theImage) {
//            formData appendPartWithFileData:theImage name:<#(nonnull NSString *)#> fileName:@"avatar.png" mimeType:@"image/png"
//        }
//      
//        
//    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//        
//    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
//        
//    }];
    
}



- (CustomTextField *)userTextField
{
    
    
    if (!_userTextField) {
        _userTextField=[[CustomTextField alloc]initWithFrame:CGRectMake(kEdgeWith, kHeight*kDeviceFactor+25, kDeviceWidth-2*kEdgeWith, 40) Placeholder:@"用户名" BackgroundColor:[UIColor whiteColor] TextColor:kColor_Placeholder_Color];
    }

    return _userTextField;
}

- (CustomTextField *)emailTextField
{
    if (!_emailTextField) {
        _emailTextField=[[CustomTextField alloc]initWithFrame:CGRectMake(kEdgeWith, kHeight*kDeviceFactor+25+40+10, kDeviceWidth-2*kEdgeWith, 40) Placeholder:@"邮箱" BackgroundColor:[UIColor whiteColor] TextColor:kColor_Placeholder_Color];
    }
    return _emailTextField;
}

- (CustomTextField *)passwordTextField
{
    if (!_passwordTextField) {
        _passwordTextField=[[CustomTextField alloc]initWithFrame:CGRectMake(kEdgeWith, kHeight*kDeviceFactor+25+40+10, kDeviceWidth-2*kEdgeWith, 40) Placeholder:@"密码" BackgroundColor:[UIColor whiteColor] TextColor:kColor_Placeholder_Color];
    }
    return _passwordTextField;
}


- (UIButton *)avatarBtn
{
    if (!_avatarBtn) {
        _avatarBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _avatarBtn.frame=CGRectMake(0, 0, 80, 80);
        _avatarBtn.center=CGPointMake(kDeviceWidth/2, (kHeight-125)*kDeviceFactor);
        [_avatarBtn setImage:[UIImage imageNamed:@"avatardefault@2x.png"] forState:UIControlStateNormal];
        [_avatarBtn addTarget:self action:@selector(clickAvatar) forControlEvents:UIControlEventTouchUpInside];
        _avatarBtn.layer.masksToBounds=YES;
        _avatarBtn.layer.cornerRadius=40;
    }
    return _avatarBtn;
}

- (void)clickAvatar
{
 
    [self pickImageFromAlbum];
}


- (UIButton *)loginBtn
{
    if (!_loginBtn) {
           _loginBtn=[UIButton ButtonWithRect:CGRectMake(kEdgeWith, kHeight*kDeviceFactor+25+40+10+40+10, (kDeviceWidth-2*kEdgeWith-5)*3/5, 40) title:@"登录" titleColor:[UIColor whiteColor] BackgroundImageWithColor:kColor_RegBack_Color clickAction:@selector(loginAction) viewController:self titleFont:12 contentEdgeInsets:UIEdgeInsetsZero];
    }
    return _loginBtn;
 
}

- (void)completeBtnEnable:(BOOL)enabled
{
    if (_loginBtn) {
        _loginBtn.enabled=enabled;
    }
}
- (void)loginAction
{
    NSString * user = [_userTextField.textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//    NSString * email = [_emailTextField.textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString * password = [_passwordTextField.textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [self completeBtnEnable:NO];
    if ([user length]==0) {
        [self  showToast:@"姓名不能为空!"];
        _userTextField.textField.text = @"";
        [self completeBtnEnable:YES];
        return;
    }
    [dic setObject:user forKey:@"username"];
//    if ([email length]==0) {
//        [self  showToast:@"邮箱不能为空!"];
//        _emailTextField.textField.text = @"";
//        [self completeBtnEnable:YES];
//        return;
//    }
    //[dic setObject:email forKey:@"email"];
    if ([password length]==0) {
        [self  showToast:@"输入的密码不能为空!"];
        _passwordTextField.textField.text = @"";
        [self completeBtnEnable:YES];
        return;
    }
    
    [dic setObject:[password MD5]  forKey:@"password"];
    
    
    [self registerHttp:dic];
    
}

- (void)registerHttp:(NSDictionary *)dic
{
    
    [self postRequestParam:dic AppURL:AppURL_Login isHead:YES CompleteBlock:^(NSDictionary *dic) {
        if ([[dic stringForKey:@"code"]intValue] ==0) {
            
            [self showToast:[dic stringForKey:@"msg"]];
            
        }
        else if([[dic stringForKey:@"code"] intValue]==1)
        {
            
            NSDictionary *data=[dic dictionaryForKey:@"data"];
            [[UserEntity instance] setUserId:[data stringForKey:@"sessionId"]];
            [[UserEntity instance] setUserToken:[data stringForKey:@"token"]];
            [[UserEntity instance]  setAccessToken:[data stringForKey:@"accessToken"]];
            [[UserEntity instance] setUName:_userTextField.textField.text];
            
            [self showToast:[dic stringForKey:@"msg"]];
            
        }
        
        
        [self completeBtnEnable:YES];
        
        AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
        [myDelegate showRootViewController];
        

        
    } errorBlock:^(NSError *error) {
        
    }];
    
}

- (UIButton *)forgetPasswordBtn
{
    if (!_forgetBtn) {
        _forgetBtn=[UIButton ButtonWithRect:CGRectMake(kEdgeWith+(kDeviceWidth-2*kEdgeWith-5)*3/5+5, kHeight*kDeviceFactor+25+40+10+40+10, (kDeviceWidth-2*kEdgeWith-5)*2/5, 40) title:@"注册" titleColor:[UIColor blackColor] BackgroundImageWithColor:kColor_LoginBack_Color clickAction:@selector(forgetAction) viewController:self titleFont:12 contentEdgeInsets:UIEdgeInsetsZero];
    }
    return _forgetBtn;
    
}

- (void)forgetAction
{
    
    RegisterViewController *reg=[[RegisterViewController alloc]init];
    [self presentViewController:reg animated:YES completion:nil];
}



- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight)];
        
    }
    return _scrollView;
}

- (UIImageView *)bgImage
{
    UIImageView *bgImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kHeight*kDeviceFactor)];
    bgImage.image=[UIImage imageNamed:@"sign_cover@2x.png"];
    return bgImage;
}




#pragma mark 从用户相册获取图片

- (void)pickImageFromAlbum
{
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    imagePicker.allowsEditing = NO;
    [self presentViewController:imagePicker animated:YES completion:nil];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo NS_DEPRECATED_IOS(2_0, 3_0)
{
   
    NSLog(@"123123");
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
     NSLog(@"123123 Cancel");
     [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image= [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        // UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    }
    theImage = [self imageWithImageSimple:image scaledToSize:CGSizeMake(120.0, 120.0)];
    
    [_avatarBtn setImage:theImage forState:UIControlStateNormal];
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
