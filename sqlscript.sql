CREATE TABLE Persons (
    PersonID INT IDENTITY(1,1) NOT NULL
           CONSTRAINT PK_Persons PRIMARY KEY CLUSTERED,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    MentorID INT NULL,
            CONSTRAINT FK_Person_Persons FOREIGN KEY (MentorID) REFERENCES Persons(PersonID),   -- mentor
    DateOfBirth Datetime,
    PhoneNumber VARCHAR(20) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Country VARCHAR(100),
    TelegramNickName VARCHAR(100),
    CreatedAt DATE DEFAULT GETDATE(),
    SolvewayLogin VARCHAR(100),
    UserID INT NOT NULL
                 CONSTRAINT FK_Persons_Users FOREIGN KEY REFERENCES AspNetUsers(ID),
);


CREATE TABLE CourseApplications (
    CourseID INT IDENTITY(1,1) NOT NULL
                  CONSTRAINT PK_Courses PRIMARY KEY CLUSTERED,
         CourseType  VARCHAR(100) NOT NULL,
         StartDate DATETIME NOT NULL,
         EndDate DATETIME NULL,
         Status VARCHAR(100) NOT NULL,
         Description VARCHAR(200) NULL,
         Cost DECIMAL(10,2) CHECK (Cost >= 0) NOT NULL,
         PriceWithDiscount DECIMAL(10,2) CHECK (PriceWithDiscount >= 0) NULL,
         Duration VARCHAR(100) NULL,
         CoverageImage VARCHAR(8000) NULL,
          ApplicationStartDate DATETIME NULL,
          ApplicationEndDate DATETIME NULL,
         ApplicationStatus VARCHAR(100) NOT NULL,
);


CREATE TABLE Applications(
         ApplicationID INT IDENTITY(1,1) NOT NULL
                   CONSTRAINT PK_Applications PRIMARY KEY CLUSTERED,
         StudentID INT NOT NULL,
                   CONSTRAINT FK_Application_Students FOREIGN KEY (StudentID) REFERENCES Persons(PersonID),
         CourseID INT NOT NULL,
                   CONSTRAINT FK_Application_CourseApplication FOREIGN KEY (CourseID) REFERENCES CourseApplications(CourseID),
         SubmittedOn DATETIME NOT NULL,
         Status VARCHAR(100) NOT NULL,
);


CREATE TABLE Divisions(
         DivisionID INT IDENTITY(1,1) NOT NULL
                        CONSTRAINT PK_Divisions PRIMARY KEY CLUSTERED,
         DivisionName VARCHAR(100) NOT NULL,
         DivisionDescription VARCHAR(255) NULL,
     IsActive BIT NOT NULL,
         Cost DECIMAL(10,2) CHECK (Cost >= 0) NULL,
         PriceWithDiscount DECIMAL(10,2) CHECK (PriceWithDiscount >= 0) NULL,
);


CREATE TABLE CourseDivisions( 
     CourseDivisionID INT NOT NULL,
          CONSTRAINT PK_CourseDivisions PRIMARY KEY (DivisionID),
          DivisionID INT NOT NULL,
          CONSTRAINT FKCourseDivisions FOREIGN KEY (DivisionID) REFERENCES Divisions(DivisionID),
         CourseID INT NOT NULL,
               CONSTRAINT FK_CourseDivision_Courses FOREIGN KEY (CourseID) REFERENCES CourseApplications(CourseID), 
);


CREATE TABLE Languages(
         LanguageID INT IDENTITY(1,1) NOT NULL
                  CONSTRAINT PK_Languages PRIMARY KEY CLUSTERED,
         LanguageName VARCHAR(100) NOT NULL,
         LanguageCode VARCHAR(5) NULL,
);


CREATE TABLE CourseTranslations(
         CourseTranslationID INT IDENTITY(1,1) NOT NULL
                   CONSTRAINT PK_CourseTranslations PRIMARY KEY CLUSTERED,
         CourseID INT NOT NULL,
                   CONSTRAINT FK_CourseTranslation_Courses FOREIGN KEY (CourseID) REFERENCES CourseApplications(CourseID),
         LanguageID INT NOT NULL,
                   CONSTRAINT FK_CourseTranslation_Languages FOREIGN KEY (LanguageID) REFERENCES Languages(LanguageID),
         CourseName VARCHAR(100) NOT NULL,
         Description VARCHAR(200) NULL,
         CoverageImage VARCHAR(8000) NULL,
);


CREATE TABLE Questions(
         QuestionID INT IDENTITY(1,1) NOT NULL
                 CONSTRAINT PK_Questions PRIMARY KEY CLUSTERED,
         CourseID INT NOT NULL,
                 CONSTRAINT FK_Questions_CoursesApplications FOREIGN KEY (CourseID) REFERENCES CourseApplications(CourseID),
         FieldType VARCHAR(100) NOT NULL,
         IsRequired BIT NOT NULL,
);


CREATE TABLE QuestionTranslations(
         QuestionTranslationID INT IDENTITY(1,1) NOT NULL
                 CONSTRAINT PK_QuestionTranslations PRIMARY KEY CLUSTERED,
         QuestionID INT NOT NULL,
                 CONSTRAINT FK_QuestionTranslations_Questions FOREIGN KEY (QuestionID) REFERENCES Questions(QuestionID),
         LanguageID INT NOT NULL,
                 CONSTRAINT FK_QuestionTranslations_Languages FOREIGN KEY (LanguageID) REFERENCES Languages(LanguageID),
         QuestionDescription VARCHAR(200) NULL,
        -- QuestionOption VARCHAR(200) NULL,
);


CREATE TABLE QuestionOptions(
         OptionID INT IDENTITY(1,1) NOT NULL
                 CONSTRAINT PK_QuestionOptions PRIMARY KEY CLUSTERED,
         QuestionID INT NOT NULL,
                 CONSTRAINT FK_QuestionOptions_Questions FOREIGN KEY (QuestionID) REFERENCES Questions(QuestionID),
         OptionDescription VARCHAR(100) NULL,  
         IsChecked BIT NOT NULL,
);


CREATE TABLE Responses(
         ResponseID INT IDENTITY(1,1) NOT NULL
             CONSTRAINT PK_Responses PRIMARY KEY CLUSTERED,
         ApplicationID INT NOT NULL
             CONSTRAINT FK_Responses_Applications FOREIGN KEY (ApplicationID) REFERENCES Applications(ApplicationID),
         Response VARCHAR(100) NOT NULL,
         IsChecked BIT NOT NULL,
         OptionId INT NULL,
             CONSTRAINT FK_Responses_QuestionOptions FOREIGN KEY (OptionId) REFERENCES QuestionOptions(OptionId),
);


CREATE TABLE QuestionAnswers (
        QuestionAnswerID INT IDENTITY(1,1) NOT NULL --AUTO_INCREMENT
                CONSTRAINT PK_QuestionAnswers PRIMARY KEY CLUSTERED,
        QuestionID INT NOT NULL
                CONSTRAINT FK_QuestionAnswers_Questions FOREIGN KEY (QuestionID) REFERENCES Questions(QuestionID),
        ResponseID INT NOT NULL
                CONSTRAINT FK_QuestionAnswers_Responses FOREIGN KEY (ResponseID) REFERENCES Responses(ResponseID)
);