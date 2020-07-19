# ToDoApp

This app is a To Do list made with Swift 4 on Xcode 9.2. It uses TableView controllers to display To Do list and To Do Items.

You can create and edit To Do Items in the list. Swipe to delete allows to definitely remove an item from a list.
When you are done with an item, you can swipe to the left and the check button with be added to the task.

## To Do Items

* User can **successfully add, edit, check and remove** items from the todo list
* Unlimited number of tasks

<img src="https://user-images.githubusercontent.com/44531649/87248779-5e5e9880-c410-11ea-8f46-8e4fb0bb248b.png" />

## Project Structure

The project has three view controllers, all embedded in a navigation controller.

<img src=https://user-images.githubusercontent.com/44531649/87248610-3a4e8780-c40f-11ea-8692-82746897d3a8.png />

## Project Flow

1. In the first view controller the user can hit the **+** button which will segue to the second view controller **(AddTodoViewController)** and the **Contact Us** button will segue to the third view controller **(ContactUsController)**.
2. In the second view controller user can create a new task and when they click **Done** button the task will be added in the list that is in the first view controller.
3. The third view controller is **Contact Us** which holds the information that the user can contact if they have any questions or feedback.
