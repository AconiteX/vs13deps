//
// $safeitemname$.xaml.cpp
// Implementation of the $safeitemname$ class.
//

#include "pch.h"
#include <ppltasks.h>
#include "$safeitemname$.xaml.h"

using namespace $rootnamespace$;

using namespace Concurrency;
using namespace Platform;
using namespace Windows::ApplicationModel::Activation;
using namespace Windows::Foundation;
using namespace Windows::Foundation::Collections;
using namespace Windows::Storage::Streams;
using namespace Windows::UI::Xaml;
using namespace Windows::UI::Xaml::Controls;
using namespace Windows::UI::Xaml::Controls::Primitives;
using namespace Windows::UI::Xaml::Data;
using namespace Windows::UI::Xaml::Input;
using namespace Windows::UI::Xaml::Media;
using namespace Windows::UI::Xaml::Media::Imaging;
using namespace Windows::UI::Xaml::Navigation;

// The Share Target Contract item template is documented at http://go.microsoft.com/fwlink/?LinkId=234241

$wizardcomment$$safeitemname$::$safeitemname$()
{
	InitializeComponent();
}

/// <summary>
/// Invoked when another application wants to share content through this application.
/// </summary>
/// <param name="args">Activation data used to coordinate the process with Windows.</param>
void $safeitemname$::Activate(ShareTargetActivatedEventArgs^ args)
{
	_shareOperation = args->ShareOperation;

	// Communicate metadata about the shared content through the view model
	auto shareProperties = _shareOperation->Data->Properties;
	auto thumbnailImage = ref new BitmapImage();
	DefaultViewModel->Insert("Title", shareProperties->Title);
	DefaultViewModel->Insert("Description", shareProperties->Description);
	DefaultViewModel->Insert("Image", thumbnailImage);
	DefaultViewModel->Insert("Sharing", false);
	DefaultViewModel->Insert("ShowImage", false);
	DefaultViewModel->Insert("Comment", "");
	DefaultViewModel->Insert("SupportsComment", true);
	Window::Current->Content = this;
	Window::Current->Activate();

	// Update the shared content's thumbnail image in the background
	if (shareProperties->Thumbnail != nullptr)
	{
		// Create a PPL task to handle the async read
		Concurrency::task<IRandomAccessStreamWithContentType^>
			readStreamTask(shareProperties->Thumbnail->OpenReadAsync());
		readStreamTask.then([this, thumbnailImage](IRandomAccessStreamWithContentType^ stream)
		{
			// Show the image once it has been read
			thumbnailImage->SetSource(stream);
			DefaultViewModel->Insert("ShowImage", true);
		}, task_continuation_context::use_current());
	}
}

/// <summary>
/// Invoked when the user clicks the Share button.
/// </summary>
/// <param name="sender">Instance of Button used to initiate sharing.</param>
/// <param name="e">Event data describing how the button was clicked.</param>
void $safeitemname$::ShareButton_Click(Object^ sender, RoutedEventArgs^ e)
{
	(void) sender;	// Unused parameter
	(void) e;	// Unused parameter

	DefaultViewModel->Insert("Sharing", true);
	_shareOperation->ReportStarted();

	// TODO: Perform work appropriate to your sharing scenario using _shareOperation->Data,
	//       typically with additional information captured through custom user interface
	//       elements added to this page such as DefaultViewModel->Lookup("Comment")

	_shareOperation->ReportCompleted();
}
