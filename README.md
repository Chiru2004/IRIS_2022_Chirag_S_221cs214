# MessManager

My flutter project for the IRIS app team recruitment.

## Application Details
<details>
<summary>  About the application </summary>
<br> This app helps students register for their college food mess and grants them additional features like viewing menus and food options, requesting a mess change, and managing their mess finances. It makes the whole process simple, straightforward, and easy to use. With MessManager, managing your college food mess is simple, convenient, and stress-free
</details>

<details>
  <summary>
    List of features implemented:
  </summary>
  <br>
 Role based login:
    
 Both the user and admin can open their corresponnding section the app using the same page. 
 <br><br>
 <img src="/assets/icon/Screenshot_1705234025.png" alt="My Image" width="170" height="350"> 
   <br>
  ##  User: 
  
 ### 1. User Registration:
 
  The user must sign up for the mess for the first time through the signup :<br>
  Once the sign up is done, user has to register for the mess,<br>
  which includes chosing the mess, selecting the data and the corresponding mess balance.
    <br>
    <br>
    <img src="/assets/icon/signup_user.png" alt="My Image" width="170" height="350"> -> <img src="/assets/icon/Landingpage_user.png" alt="My Image" width="170" height="350"> -> <img src="/assets/icon/messbalance_and_date.png" alt="My Image" width="170" height="350"> -> <img src="/assets/icon/available_mess.png" alt="My Image" width="170" height="350"> -> <img src="/assets/icon/confirming_mess_regiistration.png" alt="My Image" width="170" height="350">
<br> Finally after registering the User detail along with the mess detail will be shown.
<br><br>
<img src="/assets/icon/messdetails_and_user_details.png" alt="My Image" width="170" height="350">
<br><br>
### 2. Mess balance top up: <br>
  Once the mess balance is less than the per day cost of the mess, the user can increase the mess balance
  - Select the side drawer in the user screen
  - If mess balance is less then per day cost, then "Add mess balance" will be enabled
  - Enter the amount to be added
  - Confirm the additon of the balance
<br>
<img src="/assets/icon/messb1.jpg" alt="My Image" width="170" height="350"> -> <img src="/assets/icon/messb2.jpg" alt="My Image" width="170" height="350"> -> <img src="/assets/icon/messb3.jpg" alt="My Image" width="170" height="350"> -> <img src="/assets/icon/messb4.jpg" alt="My Image" width="170" height="350">
<br>

## Admin
Admin has several access in the app.<br>
### 1. Adding a new mess and delete the mess:
<br>
Admin can set the parameters such as the 
- Mess type
- Per day cost of the mess
- Total occupants in the mess
- The mess menu
  <br> here is the flow of through the screen shots:
  <br><br>
  <img src="/assets/icon/loginadmin.jpg" alt="My Image" width="170" height="350"> -> <img src="/assets/icon/messviewb.jpg" alt="My Image" width="170" height="350"> -> <img src="/assets/icon/messadd.jpg" alt="My Image" width="170" height="350"> -> <img src="/assets/icon/messviewaf.jpg" alt="My Image" width="170" height="350">
  <br> Similarly the mess can be deleted.
  <br><br>
### 2. User Deallocation from any mess: <br>
 Mess admin can view the users of each mess and can individually deallocate each user from the mess<br>
The procedure is simple
- select the messuser button in the mess screen,
- all users will be shown
- press deallocate, and then confirm it
- the user will be deallocated from that mess
<br>
<img src="/assets/icon/messviewaf.jpg" alt="My Image" width="170" height="350"> -> <img src="/assets/icon/messdusers.jpg" alt="My Image" width="170" height="350"> -> <img src="/assets/icon/messdconfirm.jpg" alt="My Image" width="170" height="350"> -> <img src="/assets/icon/messdaf.jpg" alt="My Image" width="170" height="350">
<br> Thus the user will be deallocated

## Mess Change
This app has the feature, wherein 
- the user can apply for a mess change
- the request is sent to the user
- The admin has to either accept or reject the request
- If accepted the mess of the user will be changed
<br> Following are the screenshots to show the flow:
<br>
### Sending request from the user side: 
<br><br>
<img src="assets/icon/messc1.jpg" alt="My Image" width="170" height="350"> -> <img src="assets/icon/messc2.jpg" alt="My Image" width="170" height="350"> -> <img src="assets/icon/messc3.jpg" alt="My Image" width="170" height="350"> -> <img src="assets/icon/messc4.jpg" alt="My Image" width="170" height="350"> <br>
<br> 
### Managing request from the user side:
<br>
<img src="assets/icon/messc5.jpg" alt="My Image" width="170" height="350"> -> <img src="assets/icon/messc6.jpg" alt="My Image" width="170" height="350"> -> <img src="assets/icon/messc7.jpg" alt="My Image" width="170" height="350"> <br>
In this way the corresponding mess changes can be handled by the admins.
</details>
<details>
    <summary>
     Apk file for the app: <br>
    </summary>
     Note: To access the admin screen just type admin in the username and press enter
     <br>
    <a href="https://drive.google.com/drive/folders/1sYOsiO0OoUzm4vHy0a9gEdSFQKVSlUDo?usp=drive_link.">Link to APK</a>
  <br>
  <br> Video for the app: <br>
   <a href="https://drive.google.com/drive/folders/1IJbD00SqSI2sdXhzFMYlFCyh0oqezDGJ?usp=sharing">Link to Vedio</a>
  </details>
  <details>
    <summary>
      List of references: <br>
    </summary>
     <a href="https://youtu.be/THCkkQ-V1-8?si=BfN39e9PYNFCsxRj">Flutterly</a>
    <br>
    <a href="https://www.udemy.com/">Udemy course</a>
  </details>
    
  <details>
  <summary>
    List of non-implemented features:
  </summary>
     - Proper statemanagement technique
     <br>
     - Dynamic deduction of mess balance using firebase functions
     <br>
     - Notifications to both user and admin using Firebase cloud messaging
     <br>
     - A very UI
  </details>
 <details>
   <summary>
     List of design tools used
   </summary>
   - Figma
 </details>
