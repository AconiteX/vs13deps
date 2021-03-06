' The File Open Picker Contract item template is documented at http://go.microsoft.com/fwlink/?LinkId=234239

''' <summary>
''' This page displays files owned by the application so that the user can grant another application
''' access to them.
''' </summary>
Public NotInheritable Class $safeitemname$
    Inherits Page

    ''' <summary>
    ''' This can be changed to a strongly typed view model.
    ''' </summary>
    Public ReadOnly Property DefaultViewModel As Common.ObservableDictionary
        Get
            Return Me._defaultViewModel
        End Get
    End Property
    Private _defaultViewModel As New Common.ObservableDictionary()

    ''' <summary>
    ''' Files are added to or removed from the Windows UI to let Windows know what has been selected.
    ''' </summary>
    Private _fileOpenPickerUI As Windows.Storage.Pickers.Provider.FileOpenPickerUI

    Public Sub New()
        InitializeComponent()
        AddHandler Window.Current.SizeChanged, AddressOf Winow_SizeChanged
        InvalidateVisualState()
    End Sub

    ''' <summary>
    ''' Invoked with the Window changes size
    ''' </summary>
    ''' <param name="sender">The current Window</param>
    ''' <param name="e">Event data that describes the new size of the Window</param>
    Private Sub Winow_SizeChanged(sender As Object, e As Windows.UI.Core.WindowSizeChangedEventArgs)
        Me.InvalidateVisualState()
    End Sub


    Private Sub InvalidateVisualState()
        Dim visualState As String = DetermineVisualState()
        VisualStateManager.GoToState(Me, visualState, False)
    End Sub

    ''' <summary>
    ''' Invoked to determine the name of the visual state that corresponds to an application
    ''' view state.
    ''' </summary>
    ''' <returns>The name of the desired visual state.  This is the same as the name of the
    ''' view state except when there is a selected item in portrait and snapped views where
    ''' this additional logical page is represented by adding a suffix of _Detail.</returns>
    Private Function DetermineVisualState() As String

        If Window.Current.Bounds.Width >= 500 Then
            Return "HorizontalView"
        Else
            Return "VerticalView"
        End If

    End Function


    ''' <summary>
    ''' Invoked when another application wants to open files from this application.
    ''' </summary>
    ''' <param name="e">Activation data used to coordinate the process with Windows.</param>
    Public Sub Activate(e As FileOpenPickerActivatedEventArgs)
        Me._fileOpenPickerUI = e.FileOpenPickerUI
        AddHandler CType(Me._fileOpenPickerUI, Windows.Storage.Pickers.Provider.FileOpenPickerUI).FileRemoved, AddressOf Me.FilePickerUI_FileRemoved

        ' TODO: Set Me.DefaultViewModel("Files") to show a collection of items,
        '       each of which should have a bindable Image, Title, and Description

        Me.DefaultViewModel("CanGoUp") = False
        Window.Current.Content = Me
        Window.Current.Activate()
    End Sub

    ''' <summary>
    ''' Invoked when user removes one of the items from the Picker basket
    ''' </summary>
    ''' <param name="sender">The FileOpenPickerUI instance used to contain the available files.</param>
    ''' <param name="e">Event data that describes the file removed.</param>
    Private Sub FilePickerUI_FileRemoved(sender As Windows.Storage.Pickers.Provider.FileOpenPickerUI, e As Windows.Storage.Pickers.Provider.FileRemovedEventArgs)
        ' TODO: Respond to an item being deselected in the picker UI.
    End Sub

    ''' <summary>
    ''' Invoked when the selected collection of files changes.
    ''' </summary>
    ''' <param name="sender">The GridView instance used to display the available files.</param>
    ''' <param name="e">Event data that describes how the selection changed.</param>
    Private Sub FileGridView_SelectionChanged(sender As Object, e As SelectionChangedEventArgs)

        ' TODO: Update Windows UI using Me._fileOpenPickerUI.AddFile and
        '       Me._fileOpenPickerUI.RemoveFile

    End Sub

    ''' <summary>
    ''' Invoked when the "Go up" button is clicked, indicating that the user wants to pop up
    ''' a level in the hierarchy of files.
    ''' </summary>
    ''' <param name="sender">The Button instance used to represent the "Go up" command.</param>
    ''' <param name="e">Event data that describes how the button was clicked.</param>
    Private Sub GoUpButton_Click(sender As Object, e As RoutedEventArgs)

        ' TODO: Set Me.DefaultViewModel("CanGoUp") to true to enable the corresponding command,
        '       use updates to Me.DefaultViewModel("Files") to reflect file hierarchy traversal

    End Sub

End Class
