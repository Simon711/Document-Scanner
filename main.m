classdef Simon_IP_Project < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                     matlab.ui.Figure
        Image                        matlab.ui.control.Image
        ClikcktochooseanimageButton  matlab.ui.control.Button
        SlidetheslidertohaveabetterouputSliderLabel  matlab.ui.control.Label
        SlidetheslidertohaveabetterouputSlider  matlab.ui.control.Slider
        DevelopedbySimonChongKaiYuenCliveLaiYiChengNgShuYuLabel  matlab.ui.control.Label
        ThisappcanprocessasnappedimageintodocumentimageLabel  matlab.ui.control.Label
        BackgroundphotoillustratedbySimonrightreserveLabel  matlab.ui.control.Label
    end

    
    methods (Access = private)
        function updateimage(app,pickedimage)
            value1 = app.SlidetheslidertohaveabetterouputSlider.Value; %input treshold value by user
            my_image = imread(pickedimage);
            my_image = my_image(:,:,:);
            processed_img = my_image;
            processed_img(my_image>=value1) = 255;
            processed_img(my_image<value1) = 0;
            imshow(processed_img,[]), title('Processed result') %If you specify an empty matrix ([]), 
            % then imshow uses a display range of [min(I(:)) max(I(:))]. 
            % In other words, the minimum value in I is black, and the maximum value is white.
            promptMessage = sprintf('Sucessfully processed! Do you want to save?');
            button = questdlg(promptMessage, 'Result', 'No', 'Yes', 'Yes');
            if strcmpi(button, 'Yes')
               	imsave();
            end
        end
        
    end


    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: ClikcktochooseanimageButton
        function ClikcktochooseanimageButtonPushed(app, event)
             % Display uigetfile dialog
            filterspec = {'*.jpg;*.tif;*.png;*.gif','All Image Files'};
            [f, p] = uigetfile(filterspec);
            
            % Make sure user didn't cancel uigetfile dialog
            if (ischar(p))
               fname = [p f];
               updateimage(app, fname);
            end
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 906 512];
            app.UIFigure.Name = 'UI Figure';

            % Create Image
            app.Image = uiimage(app.UIFigure);
            app.Image.Position = [-52 1 1015 512];
            app.Image.ImageSource = 'star.jpg';

            % Create ClikcktochooseanimageButton
            app.ClikcktochooseanimageButton = uibutton(app.UIFigure, 'push');
            app.ClikcktochooseanimageButton.ButtonPushedFcn = createCallbackFcn(app, @ClikcktochooseanimageButtonPushed, true);
            app.ClikcktochooseanimageButton.IconAlignment = 'center';
            app.ClikcktochooseanimageButton.Position = [383 53 122 57];
            app.ClikcktochooseanimageButton.Text = {'Clikck to choose '; 'an image'};

            % Create SlidetheslidertohaveabetterouputSliderLabel
            app.SlidetheslidertohaveabetterouputSliderLabel = uilabel(app.UIFigure);
            app.SlidetheslidertohaveabetterouputSliderLabel.HorizontalAlignment = 'right';
            app.SlidetheslidertohaveabetterouputSliderLabel.FontSize = 16;
            app.SlidetheslidertohaveabetterouputSliderLabel.FontColor = [1 1 1];
            app.SlidetheslidertohaveabetterouputSliderLabel.Position = [321 172 273 22];
            app.SlidetheslidertohaveabetterouputSliderLabel.Text = 'Slide the slider to have a better ouput';

            % Create SlidetheslidertohaveabetterouputSlider
            app.SlidetheslidertohaveabetterouputSlider = uislider(app.UIFigure);
            app.SlidetheslidertohaveabetterouputSlider.Limits = [0 200];
            app.SlidetheslidertohaveabetterouputSlider.MajorTicks = [0 10 20 30 40 50 60 70 80 90 100 110 120 130 140 150 160 170 180 190 200];
            app.SlidetheslidertohaveabetterouputSlider.FontSize = 16;
            app.SlidetheslidertohaveabetterouputSlider.FontColor = [1 1 1];
            app.SlidetheslidertohaveabetterouputSlider.Position = [31 270 834 3];

            % Create DevelopedbySimonChongKaiYuenCliveLaiYiChengNgShuYuLabel
            app.DevelopedbySimonChongKaiYuenCliveLaiYiChengNgShuYuLabel = uilabel(app.UIFigure);
            app.DevelopedbySimonChongKaiYuenCliveLaiYiChengNgShuYuLabel.FontColor = [1 1 1];
            app.DevelopedbySimonChongKaiYuenCliveLaiYiChengNgShuYuLabel.Position = [18 22 129 69];
            app.DevelopedbySimonChongKaiYuenCliveLaiYiChengNgShuYuLabel.Text = {'Developed by:'; ''; 'Simon Chong Kai Yuen'; 'Clive Lai Yi Cheng'; 'Ng Shu Yu'};

            % Create ThisappcanprocessasnappedimageintodocumentimageLabel
            app.ThisappcanprocessasnappedimageintodocumentimageLabel = uilabel(app.UIFigure);
            app.ThisappcanprocessasnappedimageintodocumentimageLabel.FontColor = [1 1 1];
            app.ThisappcanprocessasnappedimageintodocumentimageLabel.Position = [18 470 334 22];
            app.ThisappcanprocessasnappedimageintodocumentimageLabel.Text = 'This app can process a snapped image into document image';

            % Create BackgroundphotoillustratedbySimonrightreserveLabel
            app.BackgroundphotoillustratedbySimonrightreserveLabel = uilabel(app.UIFigure);
            app.BackgroundphotoillustratedbySimonrightreserveLabel.FontColor = [1 1 1];
            app.BackgroundphotoillustratedbySimonrightreserveLabel.Position = [607 12 287 22];
            app.BackgroundphotoillustratedbySimonrightreserveLabel.Text = 'Background photo illustrated by Simon, right reserve';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = Simon_IP_Project

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end
