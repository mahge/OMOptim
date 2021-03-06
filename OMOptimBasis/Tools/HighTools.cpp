// $Id$
/**
 * This file is part of OpenModelica.
 *
 * Copyright (c) 1998-CurrentYear, Open Source Modelica Consortium (OSMC),
 * c/o Linköpings universitet, Department of Computer and Information Science,
 * SE-58183 Linköping, Sweden.
 *
 * All rights reserved.
 *
 * THIS PROGRAM IS PROVIDED UNDER THE TERMS OF GPL VERSION 3 LICENSE OR
 * THIS OSMC PUBLIC LICENSE (OSMC-PL).
 * ANY USE, REPRODUCTION OR DISTRIBUTION OF THIS PROGRAM CONSTITUTES RECIPIENT'S ACCEPTANCE
 * OF THE OSMC PUBLIC LICENSE OR THE GPL VERSION 3, ACCORDING TO RECIPIENTS CHOICE.
 *
 * The OpenModelica software and the Open Source Modelica
 * Consortium (OSMC) Public License (OSMC-PL) are obtained
 * from OSMC, either from the above address,
 * from the URLs: http://www.ida.liu.se/projects/OpenModelica or
 * http://www.openmodelica.org, and in the OpenModelica distribution.
 * GNU version 3 is obtained from: http://www.gnu.org/copyleft/gpl.html.
 *
 * This program is distributed WITHOUT ANY WARRANTY; without
 * even the implied warranty of  MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE, EXCEPT AS EXPRESSLY SET FORTH
 * IN THE BY RECIPIENT SELECTED SUBSIDIARY LICENSE CONDITIONS OF OSMC-PL.
 *
 * See the full OSMC Public License conditions for more details.
 *
 * Main contributor 2010, Hubert Thierot, CEP - ARMINES (France)
 * Main contributor 2010, Hubert Thierot, CEP - ARMINES (France)

     @file HighTools.cpp
     @brief Comments for file documentation.
     @author Hubert Thieriot, hubert.thieriot@mines-paristech.fr
     Company : CEP - ARMINES (France)
     http://www-cep.ensmp.fr/english/
     @version

  */
#include "HighTools.h"
#include "OMCases.h"
#include "ProjectBase.h"

HighTools::HighTools(void)
{
}

HighTools::~HighTools(void)
{
}



QString HighTools::getUniqueName(QString baseName,QStringList brothers)
{
    QString result;
    int suffix;

    result=baseName;
    suffix=2;
    while(brothers.contains(result))
    {
        result=baseName+QString::number(suffix);
        suffix++;
    }

    return result;
}




void HighTools::checkUniqueProblemName(ProjectBase* project_,Problem *problem_,OMCases *problems_)
{
    QString defaultTitle;
    QString title;
    bool titleIsUnique=false;
    bool titleIsFound=false;
    int i;
    int suffix;

    //set problem title
    defaultTitle=problem_->name();
    title=defaultTitle;
    suffix=2;
    while(!titleIsUnique)
    {
        i=0;
        titleIsFound=false;
        while(i<problems_->size() && !titleIsFound)
        {
            if (title==problems_->at(i)->name())
            {
                titleIsFound=true;
                title=defaultTitle+" ("+QString::number(suffix)+")";
                suffix=suffix+1;
            }
            i++;
        }
        if (!titleIsFound)
        {
            titleIsUnique=true;
        }
    }
    problem_->setName(title);

    // save file path
    problem_->setSaveFolder(project_->problemsFolder()+QDir::separator()+problem_->name());
    problem_->setDefaultSaveFileName();
}


void HighTools::checkUniqueResultName(ProjectBase* project_,Result *result_,OMCases *results_)
{
    QString defaultTitle;
    QString title;
    bool titleIsUnique=false;
    bool titleIsFound=false;
    int i;
    int suffix;

    //set problem title
    defaultTitle=result_->name();
    title=defaultTitle;
    suffix=2;
    while(!titleIsUnique)
    {
        i=0;
        titleIsFound=false;
        while(i<results_->size() && !titleIsFound)
        {
            if (title==results_->at(i)->name())
            {
                titleIsFound=true;
                title=defaultTitle+" ("+QString::number(suffix)+")";
                suffix=suffix+1;
            }
            i++;
        }
        if (!titleIsFound)
        {
            titleIsUnique=true;
        }
    }
    result_->setName(title);

    // save file path
    result_->setSaveFolder(project_->resultsFolder()+QDir::separator()+result_->name());
    result_->setDefaultSaveFileName();
}
