/* $Id$ */

/**
* Licensed to the Apache Software Foundation (ASF) under one or more
* contributor license agreements. See the NOTICE file distributed with
* this work for additional information regarding copyright ownership.
* The ASF licenses this file to You under the Apache License, Version 2.0
* (the "License"); you may not use this file except in compliance with
* the License. You may obtain a copy of the License at
*
* http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/
package org.apache.manifoldcf.core.fuzzyml;

import org.apache.manifoldcf.core.interfaces.*;
import java.io.*;

/** This interface represents a receiver for characters.
*/
public abstract class CharacterReceiver
{
  protected Reader reader = null;
  
  /** Constructor.
  */
  public CharacterReceiver()
  {
  }
  
  /** Set the reader we'll be getting characters from.
  * It is the caller's responsibility to close this when
  * the caller has no further use for this CharacterReceiver.
  */
  public void setReader(Reader reader)
    throws IOException
  {
    this.reader = reader;
  }
  
  /** Receive a set of characters; process one chunk worth.
  *@return true if done.
  */
  public abstract boolean dealWithCharacters()
    throws IOException, ManifoldCFException;
  
  /** Finish up all processing.
  */
  public void finishUp()
    throws ManifoldCFException
  {
  }

}