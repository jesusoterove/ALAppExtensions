// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------

/// <summary>
/// Exposes functionality to retrieve and update Azure AD users.
/// </summary>
codeunit 9024 "Azure AD Graph User"
{
    Access = Public;

    trigger OnRun()
    begin
    end;

    var
        AzureADGraphUserImpl: Codeunit "Azure AD Graph User Impl.";

    /// <summary>    
    /// Gets the Azure AD user with the given security ID.
    /// </summary>
    /// <param name="UserSecurityId">The user's security ID.</param>
    /// <param name="User">The Azure AD user.</param>
    [Scope('OnPrem')]
    [TryFunction]
    procedure GetGraphUser(UserSecurityId: Guid; var User: DotNet UserInfo)
    begin
        AzureADGraphUserImpl.GetGraphUser(UserSecurityId, false, User);
    end;

    /// <summary>    
    /// Gets the Azure AD user with the given security ID.
    /// </summary>
    /// <param name="UserSecurityId">The user's security ID.</param>
    /// <param name="ForceFetchFromGraph">Forces a graph call to get the latest details for the user.</param>
    /// <param name="User">The Azure AD user.</param>
    [Scope('OnPrem')]
    [TryFunction]
    procedure GetGraphUser(UserSecurityId: Guid; ForceFetchFromGraph: Boolean; var User: DotNet UserInfo)
    begin
        AzureADGraphUserImpl.GetGraphUser(UserSecurityId, ForceFetchFromGraph, User);
    end;

    /// <summary>
    /// Retrieves the user’s unique identifier, which is its object ID, from Azure AD.
    /// </summary>
    /// <param name="UserSecurityId">The user's security ID.</param>
    /// <returns>
    /// The object ID of the Azure AD user, or an empty string if the user cannot be found.
    /// </returns>
    [Scope('OnPrem')]
    procedure GetObjectId(UserSecurityId: Guid): Text
    begin
        exit(AzureADGraphUserImpl.GetObjectId(UserSecurityId));
    end;

    /// <summary>    
    /// Gets the user's authentication object ID.
    /// </summary>
    /// <param name="UserSecurityId">The user's security ID.</param>
    /// <returns>The user's authentication object ID.</returns>
    [Scope('OnPrem')]
    procedure GetUserAuthenticationObjectId(UserSecurityId: Guid): Text
    begin
        exit(AzureADGraphUserImpl.GetUserAuthenticationObjectId(UserSecurityId));
    end;

    /// <summary>    
    /// Updates the user record with information from Azure AD.
    /// </summary>
    /// <param name="User">The user record to update.</param>
    /// <param name="AzureADUser">The Azure AD user.</param>
    /// <returns>True if the user record has been updated. Otherwise, false.</returns>
    [Scope('OnPrem')]
    procedure UpdateUserFromAzureGraph(var User: Record User; var AzureADUser: DotNet UserInfo): Boolean
    begin
        exit(AzureADGraphUserImpl.UpdateUserFromAzureGraph(User, AzureADUser));
    end;

    /// <summary>    
    /// Gets the authentication email of the provided Graph user.
    /// </summary>
    /// <remarks>Authentication email corresponds to userPrincipalName property on the Graph user.</remarks>
    /// <param name="GraphUser">The Azure AD user.</param>
    /// <returns>The authentication email of the provided Graph user. Can be used to assign to "Authentication Email" field on the User table.</returns>
    [Scope('OnPrem')]
    procedure GetAuthenticationEmail(GraphUser: DotNet UserInfo): Text[250]
    begin
        exit(AzureADGraphUserImpl.GetAuthenticationEmail(GraphUser));
    end;

    /// <summary>    
    /// Gets the display name of the provided Graph user.
    /// </summary>
    /// <remarks>Display name corresponds to displayName property on the Graph user.</remarks>
    /// <param name="GraphUser">The Azure AD user.</param>
    /// <returns>The display name of the provided Graph user. Can be used to assign to "User Name" field on the User table.</returns>
    [Scope('OnPrem')]
    procedure GetDisplayName(GraphUser: DotNet UserInfo): Text[50]
    begin
        exit(AzureADGraphUserImpl.GetDisplayName(GraphUser));
    end;

    /// <summary>    
    /// Gets the contact email of the provided Graph user.
    /// </summary>
    /// <remarks>Contact email corresponds to Mail property on the Graph user.</remarks>
    /// <param name="GraphUser">The Azure AD user.</param>
    /// <returns>The contact email of the provided Graph user. Can be used to assign to "Contact Email" field on the User table.</returns>
    [Scope('OnPrem')]
    procedure GetContactEmail(GraphUser: DotNet UserInfo): Text[250]
    begin
        exit(AzureADGraphUserImpl.GetContactEmail(GraphUser));
    end;

    /// <summary>    
    /// Gets the full name of the provided Graph user.
    /// </summary>
    /// <remarks>Full name is composed from the combination of givenName and surname properties on the Graph user.</remarks>
    /// <param name="GraphUser">The Azure AD user.</param>
    /// <returns>The full name of the provided Graph user. Can be used to assign to "Full Name" field on the User table.</returns>
    [Scope('OnPrem')]
    procedure GetFullName(GraphUser: DotNet UserInfo): Text[80]
    begin
        exit(AzureADGraphUserImpl.GetFullName(GraphUser));
    end;

    /// <summary>    
    /// Gets the preferred language ID of the provided Graph user.
    /// </summary>
    /// <remarks>Preferred language ID is derived from preferredLanguage property on the Graph user.</remarks>
    /// <param name="GraphUser">The Azure AD user.</param>
    /// <returns>The preferred language ID of the provided Graph user. Can be used to set the preferred language using the Language module.</returns>
    [Scope('OnPrem')]
    procedure GetPreferredLanguageID(GraphUser: DotNet UserInfo): Integer
    begin
        exit(AzureADGraphUserImpl.GetPreferredLanguageID(GraphUser));
    end;

    /// <summary>    
    /// Ensures that an email address specified for authorization is not already in use by another database user.
    /// If it is, all the database users with this authentication email address are updated and their email 
    /// addresses are updated the ones that are specified in Azure AD.
    /// </summary>
    /// <param name="AuthenticationEmail">The authentication email address.</param>
    [Scope('OnPrem')]
    procedure EnsureAuthenticationEmailIsNotInUse(AuthenticationEmail: Text)
    begin
        AzureADGraphUserImpl.EnsureAuthenticationEmailIsNotInUse(AuthenticationEmail);
    end;

    /// <summary>
    /// Sets a flag that is used to determine whether a test is in progress or not.
    /// </summary>
    /// <param name="TestInProgress">The value to be set to the flag.</param>
    [Scope('OnPrem')]
    procedure SetTestInProgress(TestInProgress: Boolean)
    begin
        AzureADGraphUserImpl.SetTestInProgress(TestInProgress);
    end;
}