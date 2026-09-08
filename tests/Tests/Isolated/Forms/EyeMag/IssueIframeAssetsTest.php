<?php

/**
 * Regression coverage for Eye Mag's embedded issue editor dependencies.
 *
 * a_issue.php loads the shared eye_base.php script. That script initializes
 * jQuery UI draggable/droppable/sortable widgets at DOM ready, so the issue
 * iframe must load jQuery UI before eye_base.php executes.
 *
 * @package   OpenEMR
 * @link      https://www.open-emr.org
 * @author    OpenEMR Contributors
 * @copyright Copyright (c) 2026 OpenEMR Contributors
 * @license   https://github.com/openemr/openemr/blob/master/LICENSE GNU General Public License 3
 */

declare(strict_types=1);

namespace OpenEMR\Tests\Isolated\Forms\EyeMag;

use PHPUnit\Framework\Attributes\Group;
use PHPUnit\Framework\Attributes\Test;
use PHPUnit\Framework\TestCase;

#[Group('isolated')]
class IssueIframeAssetsTest extends TestCase
{
    #[Test]
    public function issueIframeLoadsJqueryUiBeforeSharedEyeScript(): void
    {
        $path = dirname(__DIR__, 5) . '/interface/forms/eye_mag/a_issue.php';
        $source = file_get_contents($path);
        $this->assertNotFalse($source, "Could not read {$path}");

        $headerPosition = strpos($source, "'jquery-ui'");
        $baseScriptPosition = strpos($source, '/js/eye_base.php');

        $this->assertNotFalse($headerPosition, 'a_issue.php must request the jquery-ui Header asset');
        $this->assertNotFalse($baseScriptPosition, 'a_issue.php must still load the shared eye_base.php script');
        $this->assertLessThan(
            $baseScriptPosition,
            $headerPosition,
            'jquery-ui must be requested before eye_base.php is loaded'
        );
    }
}
